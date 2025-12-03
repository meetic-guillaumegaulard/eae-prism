import 'package:flutter/material.dart';
import 'navigation_response.dart';
import 'navigation_storage.dart';
import 'screen_config.dart';
import 'component_factory.dart';
import 'form_state_manager.dart';
import 'dynamic_screen.dart';
import '../../templates/screen_layout_eae.dart';
import '../../templates/landing_screen_eae.dart';
import '../../../models/brand.dart';
import '../../../utils/api_utils.dart';

/// Callback appelé quand une action API est déclenchée
typedef OnApiAction = void Function(String endpoint, Map<String, dynamic> data);

/// Widget qui gère la navigation dynamique entre écrans
///
/// Utilise le Router natif de Flutter (Navigator) pour la navigation
class DynamicScreenNavigator extends StatefulWidget {
  /// Configuration initiale de l'écran
  final ScreenConfig initialConfig;

  /// URL de base de l'API
  final String? baseUrl;

  /// Map des actions personnalisées
  final Map<String, VoidCallback> actions;

  /// Callback quand le formulaire change
  final ValueChanged<Map<String, dynamic>>? onFormChanged;

  /// Callback lors d'un submit
  final ValueChanged<Map<String, dynamic>>? onSubmit;

  /// Callback lors d'une erreur API
  final void Function(Object error)? onApiError;

  /// Callback de debug pour voir les requêtes
  final void Function(String endpoint, Map<String, dynamic> data)? onApiRequest;

  /// Identifiant unique pour le stockage local
  final String storageId;

  /// Active la persistance des données en local
  final bool persistData;

  /// Valeurs initiales du formulaire
  final Map<String, dynamic>? initialValues;

  const DynamicScreenNavigator({
    super.key,
    required this.initialConfig,
    this.baseUrl,
    this.actions = const {},
    this.onFormChanged,
    this.onSubmit,
    this.onApiError,
    this.onApiRequest,
    this.storageId = 'default',
    this.persistData = true,
    this.initialValues,
  });

  @override
  State<DynamicScreenNavigator> createState() => DynamicScreenNavigatorState();
}

class DynamicScreenNavigatorState extends State<DynamicScreenNavigator> {
  // Stockage local
  late final NavigationStorage _storage;

  // Valeurs accumulées du formulaire
  Map<String, dynamic> _accumulatedFormValues = {};

  // Configuration courante
  late ScreenConfig _currentConfig;

  // FormState pour l'écran courant
  late FormStateManager _currentFormState;

  // État
  bool _isInitialized = false;
  bool _isLoading = false;

  /// Retourne toutes les valeurs accumulées du formulaire
  Map<String, dynamic> get formValues => _accumulatedFormValues;

  @override
  void initState() {
    super.initState();
    _storage = NavigationStorage(storageId: widget.storageId);
    _currentConfig = widget.initialConfig;
    _currentFormState = FormStateManager();
    
    // Initialise avec les valeurs initiales si fournies
    if (widget.initialValues != null) {
      _accumulatedFormValues = Map.from(widget.initialValues!);
      _restoreFormValues(_accumulatedFormValues);
    }

    _currentFormState.addListener(_onFormChanged);

    // Initialisation asynchrone
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    if (widget.persistData) {
      await _storage.init();

      // Charge les données locales
      final savedFormData = await _storage.loadFormData();
      if (savedFormData.isNotEmpty) {
        _accumulatedFormValues = savedFormData;
      }
    }

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _currentFormState.removeListener(_onFormChanged);
    _currentFormState.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    _accumulatedFormValues = {
      ..._accumulatedFormValues,
      ..._currentFormState.nestedValues,
    };
    widget.onFormChanged?.call(_accumulatedFormValues);

    if (widget.persistData && !_isLoading) {
      _storage.saveFormData(_accumulatedFormValues);
    }
  }

  /// Appelle l'API avec l'endpoint et les données actuelles du formulaire
  Future<void> callApi(String endpoint) async {
    final data = _accumulatedFormValues;
    widget.onApiRequest?.call(endpoint, data);

    try {
      final response = await ApiUtils.post(
        endpoint,
        data,
        customBaseUrl: widget.baseUrl,
      );

      final navResponse = NavigationResponse.fromJson(response);
      await _handleNavigation(navResponse, endpoint);
    } catch (e) {
      widget.onApiError?.call(e);
    }
  }

  /// Gère la navigation en fonction de la réponse du serveur
  Future<void> _handleNavigation(
      NavigationResponse response, String endpoint) async {
    final nav = response.navigation;

    // Merge les valeurs du serveur avec nos valeurs locales si présentes
    if (response.formValues != null) {
      _accumulatedFormValues = {
        ..._accumulatedFormValues,
        ...response.formValues!,
      };
    }

    if (nav.type == NavigationType.refresh) {
      // Simple refresh - pas d'animation
      setState(() {
        _currentConfig = response.screen;
        _currentFormState.clear();
        _restoreFormValues(_accumulatedFormValues);
      });

      if (widget.persistData) {
        await _storage.saveCurrentPath(endpoint);
        await _storage.saveFormData(_accumulatedFormValues);
      }
    } else {
      // Navigation : on push une nouvelle instance de DynamicScreen
      // Cela permet d'utiliser le Navigator natif de Flutter (et donc le back button, animations, etc.)
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(name: endpoint),
            builder: (context) => DynamicScreen(
              config: response.screen,
              baseUrl: widget.baseUrl,
              actions: widget.actions,
              onFormChanged: widget.onFormChanged,
              onSubmit: widget.onSubmit,
              onApiError: widget.onApiError,
              onApiRequest: widget.onApiRequest,
              initialValues: _accumulatedFormValues,
            ),
          ),
        );
      }
    }
  }

  /// Efface toutes les données persistées et réinitialise
  Future<void> clearAndReset() async {
    if (widget.persistData) {
      await _storage.clear();
    }

    _accumulatedFormValues.clear();

    // On pop jusqu'à la racine si on est dans une stack de navigation
    if (Navigator.canPop(context)) {
       Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      // Sinon on reset l'état local
      _currentFormState.removeListener(_onFormChanged);
      _currentFormState.dispose();
      _currentFormState = FormStateManager();
      _currentFormState.addListener(_onFormChanged);

      setState(() {
        _currentConfig = widget.initialConfig;
      });
    }
  }

  void _restoreFormValues(Map<String, dynamic> values) {
    _flattenAndRestore(values, '');
  }

  void _flattenAndRestore(Map<String, dynamic> values, String prefix) {
    for (final entry in values.entries) {
      final key = prefix.isEmpty ? entry.key : '$prefix.${entry.key}';
      if (entry.value is Map<String, dynamic>) {
        _flattenAndRestore(entry.value as Map<String, dynamic>, key);
      } else {
        _currentFormState.setValue(key, entry.value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return _buildContent();
  }

  Widget _buildContent() {
      return _buildScreenContent(_currentConfig, _currentFormState);
  }

  Widget _buildScreenContent(ScreenConfig config, FormStateManager formState) {
    final factory = ComponentFactory(
      formState: formState,
      actions: _buildEffectiveActions(),
      onApiAction: callApi,
    );

    return _buildScreen(config, factory);
  }

  Map<String, VoidCallback> _buildEffectiveActions() {
    final actions = Map<String, VoidCallback>.from(widget.actions);

    if (widget.onSubmit != null && !actions.containsKey('submit')) {
      actions['submit'] = () => widget.onSubmit!(_accumulatedFormValues);
    }

    actions['reset'] = () => clearAndReset();

    return actions;
  }

  Widget _buildScreen(ScreenConfig config, ComponentFactory factory) {
    switch (config.template.toLowerCase()) {
      case 'screen_layout':
        return _buildScreenLayout(config, factory);
      case 'landing':
        return _buildLandingScreen(config, factory);
      default:
        return _buildGenericScreen(config, factory);
    }
  }

  Widget _buildScreenLayout(ScreenConfig config, ComponentFactory factory) {
    // Build header widget if provided
    Widget? topBar;
    if (config.header != null && config.header!.isNotEmpty) {
      if (config.header!.length == 1) {
        topBar = factory.build(config.header!.first);
      } else {
        topBar = Column(
          mainAxisSize: MainAxisSize.min,
          children: config.header!.map((comp) => factory.build(comp)).toList(),
        );
      }
    }

    // Build content widget
    Widget content;
    if (config.content.length == 1) {
      content = factory.build(config.content.first);
    } else {
      content = Column(
        children: config.content.map((comp) => factory.build(comp)).toList(),
      );
    }

    // Build footer widget if provided
    Widget? bottomBar;
    if (config.footer != null && config.footer!.isNotEmpty) {
      if (config.footer!.length == 1) {
        bottomBar = factory.build(config.footer!.first);
      } else {
        bottomBar = Column(
          mainAxisSize: MainAxisSize.min,
          children: config.footer!.map((comp) => factory.build(comp)).toList(),
        );
      }
    }

    // Get background color from props
    Color? backgroundColor;
    final bgColorString = config.getProp<String>('backgroundColor');
    if (bgColorString != null) {
      backgroundColor = _parseColor(bgColorString);
    }

    return ScreenLayoutEAE(
      topBar: topBar,
      content: content,
      bottomBar: bottomBar,
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildLandingScreen(ScreenConfig config, ComponentFactory factory) {
    // Build content widget
    Widget content;
    if (config.content.length == 1) {
      content = factory.build(config.content.first);
    } else {
      content = Column(
        children: config.content.map((comp) => factory.build(comp)).toList(),
      );
    }

    // Build footer widget if provided
    Widget? bottomBar;
    if (config.footer != null && config.footer!.isNotEmpty) {
      if (config.footer!.length == 1) {
        bottomBar = factory.build(config.footer!.first);
      } else {
        bottomBar = Column(
          mainAxisSize: MainAxisSize.min,
          children: config.footer!.map((comp) => factory.build(comp)).toList(),
        );
      }
    }

    // Get landing config
    final landingConfig = LandingScreenConfig(
      brand: _parseBrand(config.getProp<String>('brand')) ?? Brand.match,
    );

    return LandingScreenEAE(
      config: landingConfig,
      content: content,
      bottomBar: bottomBar,
    );
  }

  Widget _buildGenericScreen(ScreenConfig config, ComponentFactory factory) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (config.header != null)
              ...config.header!.map((comp) => factory.build(comp)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: config.content
                      .map((comp) => factory.build(comp))
                      .toList(),
                ),
              ),
            ),
            if (config.footer != null)
              ...config.footer!.map((comp) => factory.build(comp)),
          ],
        ),
      ),
    );
  }

  Brand? _parseBrand(String? brandName) {
    if (brandName == null) return null;
    return switch (brandName.toLowerCase()) {
      'match' => Brand.match,
      'meetic' => Brand.meetic,
      'okc' || 'okcupid' => Brand.okc,
      'pof' || 'plentyoffish' => Brand.pof,
      _ => null,
    };
  }

  Color? _parseColor(String colorStr) {
    if (colorStr.startsWith('#')) {
      final hex = colorStr.substring(1);
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      } else if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
    }
    return null;
  }
}
