import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';

class DynamicPage extends StatefulWidget {
  final Brand brand;
  final String screenId;
  final ScreenConfig? config;
  final Map<String, dynamic>? initialValues;

  const DynamicPage({
    super.key,
    required this.brand,
    required this.screenId,
    this.config,
    this.initialValues,
  });

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  static const String _baseUrl = 'http://localhost:3000/api';

  ScreenConfig? _config;
  Map<String, dynamic>? _formValues;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  @override
  void didUpdateWidget(DynamicPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si on change de screenId ou de config, recharger
    if (widget.screenId != oldWidget.screenId) {
      _loadScreen();
    } else if (widget.config != oldWidget.config) {
      // Config fournie directement (navigation depuis un autre écran)
      setState(() {
        _config = widget.config;
        _formValues = widget.initialValues;
        _isLoading = false;
        _error = null;
      });
    }
  }

  Future<void> _loadScreen() async {
    // Si une config est fournie directement (navigation depuis POST), l'utiliser
    if (widget.config != null) {
      setState(() {
        _config = widget.config;
        _formValues = widget.initialValues;
        _isLoading = false;
        _error = null;
      });
      return;
    }

    // Sinon, charger depuis le serveur via GET
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await ApiUtils.get(
        '/screens/${widget.screenId}',
        customBaseUrl: _baseUrl,
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
            onPressed: () => context.go('/'),
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
                  onPressed: _loadScreen,
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
      baseUrl: _baseUrl,
      initialValues: _formValues,
      onFormChanged: (values) {
        debugPrint('Form values: $values');
      },
      onSubmit: (values) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Formulaire soumis: ${values.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      },
      onApiError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $error'),
            backgroundColor: Colors.red,
          ),
        );
      },
      // Navigation avec go_router - push pour avoir l'historique et les animations
      onNavigate: (response, formValues) {
        // Extraire le screenId depuis les props de l'écran
        final newScreenId = _extractScreenId(response);

        context.push(
          '/screens/$newScreenId',
          extra: {
            'config': response.screen,
            'formValues': formValues,
          },
        );
      },
      // Retour en arrière standard (apiEndpoint: ":back")
      onBack: () {
        if (context.canPop()) {
          debugPrint("message: back");
          context.pop();
        } else {
          debugPrint("message: no back");
          // Si on ne peut pas pop, retour à l'accueil
          context.go('/');
        }
      },
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
