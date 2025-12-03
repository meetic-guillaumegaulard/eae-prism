import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../models/interest.dart';
import '../data/interests_data.dart';
import '../services/recommendation_service.dart';

/// État du contrôleur de recherche vocale
class VoiceSearchState {
  final bool isListening;
  final bool isProcessing;
  final String liveTranscript;
  final String accumulatedContext;
  final List<int> filteredIds;
  final Set<int> selectedIds;
  final bool isAvailable;
  final String? error;
  final double soundLevel;
  final String? aiResponse;

  const VoiceSearchState({
    this.isListening = false,
    this.isProcessing = false,
    this.liveTranscript = '',
    this.accumulatedContext = '',
    this.filteredIds = const [],
    this.selectedIds = const {},
    this.isAvailable = false,
    this.error,
    this.soundLevel = 0.0,
    this.aiResponse,
  });

  VoiceSearchState copyWith({
    bool? isListening,
    bool? isProcessing,
    String? liveTranscript,
    String? accumulatedContext,
    List<int>? filteredIds,
    Set<int>? selectedIds,
    bool? isAvailable,
    String? error,
    double? soundLevel,
    String? aiResponse,
  }) {
    return VoiceSearchState(
      isListening: isListening ?? this.isListening,
      isProcessing: isProcessing ?? this.isProcessing,
      liveTranscript: liveTranscript ?? this.liveTranscript,
      accumulatedContext: accumulatedContext ?? this.accumulatedContext,
      filteredIds: filteredIds ?? this.filteredIds,
      selectedIds: selectedIds ?? this.selectedIds,
      isAvailable: isAvailable ?? this.isAvailable,
      error: error,
      soundLevel: soundLevel ?? this.soundLevel,
      aiResponse: aiResponse,
    );
  }

  List<Interest> get filteredInterests => getInterestsByIds(filteredIds);
  List<Interest> get selectedInterests => getInterestsByIds(selectedIds.toList());
  bool isSelected(int id) => selectedIds.contains(id);
}

/// Contrôleur de recherche vocale avec Riverpod
class VoiceSearchController extends StateNotifier<VoiceSearchState> {
  final SpeechToText _speech = SpeechToText();
  final RecommendationService _recommendationService = RecommendationService();
  
  bool _shouldContinueListening = false;
  bool _isStartingListening = false;
  
  // Timer pour détecter le silence (debounce)
  Timer? _silenceTimer;
  String _lastProcessedText = '';
  static const _silenceDuration = Duration(seconds: 2);

  VoiceSearchController() : super(const VoiceSearchState());

  /// Initialize speech-to-text service
  Future<void> initialize() async {
    print('🎤 Initializing speech-to-text...');
    try {
      final available = await _speech.initialize(
        onStatus: _onStatus,
        onError: _onError,
      );

      print('🎤 Speech available: $available');
      state = state.copyWith(
        isAvailable: available,
        error: available ? null : 'Speech recognition not available',
      );
    } catch (e) {
      print('🎤 Init error: $e');
      state = state.copyWith(
        isAvailable: false,
        error: 'Initialization error: $e',
      );
    }
  }

  /// Start listening session
  Future<void> startSession() async {
    if (!state.isAvailable) {
      await initialize();
      if (!state.isAvailable) return;
    }

    _shouldContinueListening = true;
    _lastProcessedText = '';
    state = state.copyWith(error: null, isListening: true);
    _startListening();
  }

  /// Start voice listening
  Future<void> _startListening() async {
    if (!_shouldContinueListening || !state.isAvailable) return;
    if (_speech.isListening || _isStartingListening) return;

    _isStartingListening = true;
    print('🎤 Starting listening...');

    try {
      await _speech.listen(
        onResult: _onResult,
        localeId: 'en_US', // English language
        listenFor: const Duration(minutes: 10),
        pauseFor: const Duration(seconds: 30), // We handle silence ourselves
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
          cancelOnError: false,
          partialResults: true,
          onDevice: false,
        ),
        onSoundLevelChange: (level) {
          final normalized = ((level + 2) / 12).clamp(0.0, 1.0);
          state = state.copyWith(soundLevel: normalized);
        },
      );
      _isStartingListening = false;
    } catch (e) {
      _isStartingListening = false;
      if (!e.toString().contains('already started')) {
        print('🎤 Erreur écoute: $e');
      }
    }
  }

  /// Callback appelé quand on reçoit un résultat de transcription
  void _onResult(SpeechRecognitionResult result) {
    final text = result.recognizedWords;
    
    // Met à jour le transcript live
    state = state.copyWith(liveTranscript: text);
    
    // Reset le timer de silence à chaque nouveau texte
    _resetSilenceTimer();
    
    print('🎤 Transcript: "$text"');
  }

  /// Reset le timer de silence (debounce)
  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    
    _silenceTimer = Timer(_silenceDuration, () {
      // 2 secondes sans changement = on traite le texte
      final currentText = state.liveTranscript;
      
      if (currentText.isNotEmpty && currentText != _lastProcessedText) {
        print('⏱️ 2s de silence détecté, traitement...');
        _processCurrentTranscript();
      }
    });
  }

  /// Traite le transcript actuel
  void _processCurrentTranscript() {
    final fullText = state.liveTranscript;
    if (fullText.isEmpty) return;
    
    // Extrait SEULEMENT le nouveau texte (la différence)
    String newText;
    if (_lastProcessedText.isNotEmpty && fullText.startsWith(_lastProcessedText)) {
      // Le nouveau texte = ce qui a été ajouté après le dernier traitement
      newText = fullText.substring(_lastProcessedText.length).trim();
    } else {
      newText = fullText;
    }
    
    // Si pas de nouveau texte, on ne fait rien
    if (newText.isEmpty) return;
    
    _lastProcessedText = fullText; // Mémorise le texte complet traité
    
    // Ajoute au contexte accumulé (pour affichage historique)
    final newContext = state.accumulatedContext.isEmpty
        ? newText
        : '${state.accumulatedContext}. $newText';

    state = state.copyWith(
      accumulatedContext: newContext,
    );

    print('📤 Nouveau texte à envoyer: "$newText"');
    
    // Lance l'IA avec SEULEMENT le nouveau texte
    _processWithAI(newText);
  }

  /// Traite le contexte avec l'IA
  Future<void> _processWithAI(String context) async {
    state = state.copyWith(isProcessing: true);
    print('🤖 Appel IA avec: "$context"');
    
    // Appelle l'IA avec le contexte ET la sélection actuelle
    final result = await _recommendationService.getRecommendations(
      context,
      allInterests,
      state.selectedIds,
    );

    print('🤖 À ajouter: ${result.toAdd}');
    print('🤖 À retirer: ${result.toRemove}');

    final aiResponse = result.raw ?? result.error ?? 'Pas de réponse';
    print('🤖 Réponse: $aiResponse');

    // Applique les modifications : ajoute les nouveaux, retire les exclus
    final newSelectedIds = Set<int>.from(state.selectedIds)
      ..addAll(result.toAdd)
      ..removeAll(result.toRemove);

    state = state.copyWith(
      filteredIds: result.toAdd,
      selectedIds: newSelectedIds,
      isProcessing: false,
      aiResponse: aiResponse,
    );
  }

  /// Callback de changement de statut
  void _onStatus(String status) {
    print('🎤 Status: $status');
    
    if (status == 'done' || status == 'notListening') {
      // Relance l'écoute si on veut continuer
      if (_shouldContinueListening) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (_shouldContinueListening && !_speech.isListening && !_isStartingListening) {
            _startListening();
          }
        });
      } else {
        state = state.copyWith(isListening: false);
      }
    }
  }

  /// Callback d'erreur
  void _onError(dynamic error) {
    final errorStr = error.toString();
    if (errorStr.contains('LegacyJavaScriptObject') || errorStr.contains('encodable')) {
      return; // Ignore les erreurs JS du package
    }
    print('🎤 Erreur: $errorStr');
    
    if (_shouldContinueListening) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_shouldContinueListening && !_speech.isListening) {
          _startListening();
        }
      });
    }
  }

  /// Arrête la session d'écoute
  void stopSession() {
    _shouldContinueListening = false;
    _silenceTimer?.cancel();
    _speech.stop();
    
    // Traite le texte restant avant d'arrêter
    if (state.liveTranscript.isNotEmpty && state.liveTranscript != _lastProcessedText) {
      _processCurrentTranscript();
    }
    
    state = state.copyWith(
      isListening: false,
      soundLevel: 0.0,
    );
  }

  /// Réinitialise complètement
  void reset() {
    stopSession();
    _lastProcessedText = '';
    state = const VoiceSearchState().copyWith(isAvailable: state.isAvailable);
  }

  /// Traite une entrée texte manuellement
  Future<void> processTextInput(String text) async {
    if (text.trim().isEmpty) return;
    
    final trimmedText = text.trim();
    
    // Ajoute au contexte accumulé (pour affichage)
    final newContext = state.accumulatedContext.isEmpty
        ? trimmedText
        : '${state.accumulatedContext}. $trimmedText';
    
    state = state.copyWith(accumulatedContext: newContext);
    
    // Envoie SEULEMENT la nouvelle phrase à l'IA
    await _processWithAI(trimmedText);
  }

  void toggleSelection(int id) {
    final newSelected = Set<int>.from(state.selectedIds);
    if (newSelected.contains(id)) {
      newSelected.remove(id);
    } else {
      newSelected.add(id);
    }
    state = state.copyWith(selectedIds: newSelected);
  }

  void select(int id) {
    if (!state.selectedIds.contains(id)) {
      state = state.copyWith(selectedIds: {...state.selectedIds, id});
    }
  }

  void deselect(int id) {
    if (state.selectedIds.contains(id)) {
      final newSelected = Set<int>.from(state.selectedIds)..remove(id);
      state = state.copyWith(selectedIds: newSelected);
    }
  }

  void clearSelection() {
    state = state.copyWith(selectedIds: {});
  }

  @override
  void dispose() {
    _silenceTimer?.cancel();
    stopSession();
    super.dispose();
  }
}

/// Provider du contrôleur
final voiceSearchControllerProvider =
    StateNotifierProvider.autoDispose<VoiceSearchController, VoiceSearchState>(
  (ref) => VoiceSearchController(),
);

