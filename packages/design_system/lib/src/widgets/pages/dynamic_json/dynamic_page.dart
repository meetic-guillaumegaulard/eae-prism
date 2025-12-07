import 'package:flutter/material.dart';
import '../../../utils/api_utils.dart';
import 'screen_config.dart';
import 'dynamic_screen.dart';
import 'navigation_response.dart';
import 'shared/builder_context.dart' show ExitCallback;

/// Callbacks de navigation pour DynamicPage
typedef NavigateCallback = void Function(
  String screenId,
  Map<String, dynamic> extra,
);
typedef BackCallback = void Function();
typedef GoHomeCallback = void Function();
typedef CanPopCallback = bool Function();

/// Page dynamique qui charge et affiche un écran depuis une config JSON
class DynamicPage extends StatefulWidget {
  /// ID de l'écran à charger
  final String screenId;

  /// Configuration d'écran (optionnelle, sinon chargée depuis le serveur)
  final ScreenConfig? config;

  /// Valeurs initiales du formulaire
  final Map<String, dynamic>? initialValues;

  /// URL de base de l'API
  final String baseUrl;

  /// Callback appelé lors d'une navigation vers un nouvel écran
  final NavigateCallback onNavigate;

  /// Callback appelé pour revenir en arrière
  final BackCallback onBack;

  /// Callback appelé pour retourner à l'accueil
  final GoHomeCallback onGoHome;

  /// Callback pour vérifier si on peut revenir en arrière
  final CanPopCallback canPop;

  /// Callback appelé quand l'utilisateur veut sortir du flow dynamique
  final ExitCallback? onExit;

  const DynamicPage({
    super.key,
    required this.screenId,
    this.config,
    this.initialValues,
    required this.baseUrl,
    required this.onNavigate,
    required this.onBack,
    required this.onGoHome,
    required this.canPop,
    this.onExit,
  });

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  late ScreenConfig? _config;
  late Map<String, dynamic>? _formValues;
  late bool _isLoading;
  String? _error;

  @override
  void initState() {
    super.initState();

    // Si la config est fournie, on l'utilise immédiatement (pas de loading)
    if (widget.config != null) {
      _config = widget.config;
      _formValues = widget.initialValues;
      _isLoading = false;
    } else {
      // Sinon, on doit charger depuis le serveur
      _config = null;
      _formValues = null;
      _isLoading = true;
      _loadScreenFromServer();
    }
  }

  @override
  void didUpdateWidget(DynamicPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si on change de screenId, recharger depuis le serveur
    if (widget.screenId != oldWidget.screenId && widget.config == null) {
      _loadScreenFromServer();
    } else if (widget.config != oldWidget.config && widget.config != null) {
      // Config fournie directement (navigation depuis un autre écran)
      setState(() {
        _config = widget.config;
        _formValues = widget.initialValues;
        _isLoading = false;
        _error = null;
      });
    }
  }

  /// Charge l'écran depuis le serveur (GET)
  Future<void> _loadScreenFromServer() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await ApiUtils.get(
        '/dynamic-pages/${widget.screenId}',
        customBaseUrl: widget.baseUrl,
      );

      if (response.containsKey('error')) {
        setState(() {
          _error = response['error'] as String;
          _isLoading = false;
        });
        return;
      }

      final screenJson = response['screen'] as Map<String, dynamic>;
      final formValuesFromServer =
          response['formValues'] as Map<String, dynamic>?;

      setState(() {
        _config = ScreenConfig.fromJson(screenJson);
        // Merge: les initialValues passées en paramètre ont priorité
        _formValues = {
          ...?formValuesFromServer,
          ...?widget.initialValues,
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onGoHome,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Erreur: $_error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loadScreenFromServer,
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_config == null) {
      return const Scaffold(
        body: Center(
          child: Text('Aucune configuration disponible'),
        ),
      );
    }

    return DynamicScreen(
      config: _config!,
      baseUrl: widget.baseUrl,
      initialValues: _formValues,
      onFormChanged: (values) {
        debugPrint('Form values: $values');
      },
      onApiError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      // Navigation via callbacks
      onNavigate: (response, formValues) {
        final newScreenId = _extractScreenId(response);
        final direction = response.navigation.direction.name;
        final durationMs = response.navigation.durationMs;
        final scope = response.navigation.scope.name;

        widget.onNavigate(
          newScreenId,
          {
            'config': response.screen,
            'formValues': formValues,
            'direction': direction,
            'durationMs': durationMs,
            'scope': scope,
          },
        );
      },
      // Retour en arrière standard (apiEndpoint: ":back")
      onBack: () {
        if (widget.canPop()) {
          widget.onBack();
        } else {
          // Si on ne peut pas pop, retour à l'accueil
          widget.onGoHome();
        }
      },
      // Callback appelé quand un composant a une propriété "exit"
      onExit: widget.onExit,
    );
  }

  /// Extrait le screenId depuis la réponse de navigation
  String _extractScreenId(NavigationResponse response) {
    final screenProps = response.screen.props;
    if (screenProps.containsKey('screenId')) {
      return screenProps['screenId'] as String;
    }
    // Fallback: utiliser un timestamp
    return 'screen-${DateTime.now().millisecondsSinceEpoch}';
  }
}
