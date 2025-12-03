import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/interest.dart';

/// Résultat de la recommandation IA
class RecommendationResult {
  final List<int> toAdd;
  final List<int> toRemove;
  final String? raw;
  final String? error;

  RecommendationResult({
    this.toAdd = const [],
    this.toRemove = const [],
    this.raw,
    this.error,
  });
}

/// Service de recommandation utilisant le backend proxy pour l'API OpenAI.
class RecommendationService {
  static String _backendUrl = 'http://localhost:3000';

  static void initialize(String backendUrl) {
    _backendUrl = backendUrl;
    print('✅ RecommendationService configuré: $_backendUrl');
  }

  String? lastRawResponse;
  String? lastError;

  /// Analyse la requête et retourne les IDs à ajouter/retirer
  Future<RecommendationResult> getRecommendations(
    String userQuery,
    List<Interest> availableInterests,
    Set<int> currentlySelected,
  ) async {
    lastRawResponse = null;
    lastError = null;
    
    if (userQuery.trim().isEmpty) {
      return RecommendationResult();
    }

    try {
      final requestBody = jsonEncode({
        'userQuery': userQuery,
        'interests': availableInterests.map((i) => {
          'id': i.id,
          'name': i.name,
          'category': i.category,
        }).toList(),
        'currentlySelected': currentlySelected.toList(),
      });

      print('📡 Appel backend: $_backendUrl/api/ai/recommend');

      final response = await http.post(
        Uri.parse('$_backendUrl/api/ai/recommend'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode != 200) {
        lastError = 'Erreur HTTP ${response.statusCode}';
        print('❌ $lastError');
        return RecommendationResult(error: lastError);
      }

      final data = jsonDecode(response.body);
      lastRawResponse = data['raw'] ?? 'Pas de réponse';
      
      final toAdd = (data['toAdd'] as List?)?.whereType<int>().toList() ?? [];
      final toRemove = (data['toRemove'] as List?)?.whereType<int>().toList() ?? [];
      
      // Fallback pour l'ancien format (juste "ids")
      if (toAdd.isEmpty && toRemove.isEmpty && data['ids'] != null) {
        final ids = (data['ids'] as List).whereType<int>().toList();
        return RecommendationResult(toAdd: ids, raw: lastRawResponse);
      }
      
      print('✅ À ajouter: $toAdd, À retirer: $toRemove');
      
      if (data['error'] != null) {
        lastError = data['error'];
      }
      
      return RecommendationResult(
        toAdd: toAdd,
        toRemove: toRemove,
        raw: lastRawResponse,
        error: lastError,
      );
    } catch (e) {
      lastError = e.toString();
      print('❌ Erreur: $e');
      return RecommendationResult(error: lastError);
    }
  }

  /// Ancienne méthode pour compatibilité
  Future<List<int>> getRelevantInterestIds(
    String userQuery,
    List<Interest> availableInterests,
  ) async {
    final result = await getRecommendations(userQuery, availableInterests, {});
    return result.toAdd;
  }
}

