import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen_config.dart';
import 'component_factory.dart';
import 'form_state_manager.dart';
import 'navigation_response.dart';
import '../../templates/screen_layout_eae.dart';
import '../../templates/landing_screen_eae.dart';
import '../../../models/brand.dart';
import '../../../utils/api_utils.dart';
import '../../atoms/logo_eae.dart';

/// Widget that builds a screen dynamically from JSON configuration.
/// 
/// La navigation est gérée par le parent via le callback [onNavigate].
/// Quand un bouton avec [apiEndpoint] est pressé, l'API est appelée et
/// [onNavigate] est invoqué avec la réponse. Le parent peut alors faire
/// un simple `Navigator.push` avec une nouvelle instance de DynamicScreen.
/// 
/// Exemple d'utilisation:
/// ```dart
/// DynamicScreen(
///   config: screenConfig,
///   baseUrl: 'http://localhost:3000/api',
///   onNavigate: (response, formValues) {
///     Navigator.push(
///       context,
///       MaterialPageRoute(
///         builder: (context) => DynamicScreen(
///           config: response.screen,
///           baseUrl: 'http://localhost:3000/api',
///           initialValues: formValues,
///           onNavigate: ...,
///         ),
///       ),
///     );
///   },
/// );
/// ```
class DynamicScreen extends StatefulWidget {
  /// JSON configuration as a string
  final String? jsonString;

  /// Screen configuration object (alternative to jsonString)
  final ScreenConfig? config;

  /// Map of action callbacks for buttons (referenced by "action" prop)
  final Map<String, VoidCallback> actions;

  /// Callback when form values change
  final ValueChanged<Map<String, dynamic>>? onFormChanged;

  /// Callback with form values when submit action is triggered
  final ValueChanged<Map<String, dynamic>>? onSubmit;

  /// URL de base de l'API pour les appels dynamiques
  final String? baseUrl;

  /// Callback lors d'une erreur API
  final void Function(Object error)? onApiError;

  /// Callback de debug pour voir les requêtes API
  final void Function(String endpoint, Map<String, dynamic> data)? onApiRequest;

  /// Valeurs initiales du formulaire
  final Map<String, dynamic>? initialValues;

  /// Callback appelé quand une navigation est demandée (via apiEndpoint)
  /// Le parent est responsable de faire le Navigator.push
  /// [response] contient la config du nouvel écran
  /// [formValues] contient toutes les valeurs du formulaire accumulées
  final void Function(NavigationResponse response, Map<String, dynamic> formValues)? onNavigate;

  /// Appelé quand l'écran doit simplement être rafraîchi (navigation type: refresh)
  /// Si non fourni, le refresh sera géré en interne avec setState
  final void Function(ScreenConfig newConfig, Map<String, dynamic> formValues)? onRefresh;

  const DynamicScreen({
    super.key,
    this.jsonString,
    this.config,
    this.actions = const {},
    this.onFormChanged,
    this.onSubmit,
    this.baseUrl,
    this.onApiError,
    this.onApiRequest,
    this.initialValues,
    this.onNavigate,
    this.onRefresh,
  }) : assert(
          jsonString != null || config != null,
          'Either jsonString or config must be provided',
        );

  /// Create a DynamicScreen from an asset file
  static Widget fromAsset(
    String assetPath, {
    Map<String, VoidCallback> actions = const {},
    ValueChanged<Map<String, dynamic>>? onFormChanged,
    ValueChanged<Map<String, dynamic>>? onSubmit,
    String? baseUrl,
    void Function(Object error)? onApiError,
    void Function(String endpoint, Map<String, dynamic> data)? onApiRequest,
    void Function(NavigationResponse response, Map<String, dynamic> formValues)? onNavigate,
  }) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildError('Error loading asset: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return DynamicScreen(
          jsonString: snapshot.data,
          actions: actions,
          onFormChanged: onFormChanged,
          onSubmit: onSubmit,
          baseUrl: baseUrl,
          onApiError: onApiError,
          onApiRequest: onApiRequest,
          onNavigate: onNavigate,
        );
      },
    );
  }

  @override
  State<DynamicScreen> createState() => DynamicScreenState();

  /// Build an error widget
  static Widget _buildError(String message) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// State for DynamicScreen - exposed for accessing form values
class DynamicScreenState extends State<DynamicScreen> {
  late final FormStateManager _formState;
  ScreenConfig? _currentConfig;
  String? _error;
  bool _isLoading = false;

  /// Get the current form values as a flat map
  Map<String, dynamic> get formValues => _formState.values;

  /// Get the current form values as a nested JSON structure
  Map<String, dynamic> get nestedFormValues => _formState.nestedValues;

  @override
  void initState() {
    super.initState();
    _formState = FormStateManager();
    if (widget.initialValues != null) {
      _restoreFormValues(widget.initialValues!);
    }
    _formState.addListener(_onFormChanged);
    _parseConfig();
  }

  @override
  void dispose() {
    _formState.removeListener(_onFormChanged);
    _formState.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DynamicScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.jsonString != oldWidget.jsonString ||
        widget.config != oldWidget.config) {
      _parseConfig();
    }
  }

  void _parseConfig() {
    try {
      if (widget.config != null) {
        _currentConfig = widget.config;
        _error = null;
      } else if (widget.jsonString != null) {
        final Map<String, dynamic> json = jsonDecode(widget.jsonString!);
        _currentConfig = ScreenConfig.fromJson(json);
        _error = null;
      }
    } catch (e) {
      _error = 'Error parsing config: $e';
      _currentConfig = null;
    }
  }

  void _onFormChanged() {
    widget.onFormChanged?.call(_formState.nestedValues);
  }

  /// Reset form to initial values
  void resetForm() {
    _formState.clear();
  }

  /// Set form values programmatically
  void setFormValues(Map<String, dynamic> values) {
    _restoreFormValues(values);
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
        _formState.setValue(key, entry.value);
      }
    }
  }

  /// Appelle l'API avec l'endpoint spécifié
  Future<void> callApi(String endpoint) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final data = _formState.nestedValues;
    widget.onApiRequest?.call(endpoint, data);

    try {
      final response = await ApiUtils.post(
        endpoint,
        data,
        customBaseUrl: widget.baseUrl,
      );

      final navResponse = NavigationResponse.fromJson(response);
      
      // Merge server values with local values
      final mergedValues = {
        ..._formState.nestedValues,
        if (navResponse.formValues != null) ...navResponse.formValues!,
      };

      if (navResponse.navigation.type == NavigationType.refresh) {
        // Refresh: on met à jour l'écran en place
        if (widget.onRefresh != null) {
          widget.onRefresh!(navResponse.screen, mergedValues);
        } else {
          // Gestion interne du refresh
          setState(() {
            _currentConfig = navResponse.screen;
            _formState.clear();
            _restoreFormValues(mergedValues);
          });
        }
      } else {
        // Navigate: on laisse le parent gérer le push
        widget.onNavigate?.call(navResponse, mergedValues);
      }
    } catch (e) {
      widget.onApiError?.call(e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return DynamicScreen._buildError(_error!);
    }

    if (_currentConfig == null) {
      return DynamicScreen._buildError('No configuration provided');
    }

    // Build actions map, including automatic submit action
    final effectiveActions = Map<String, VoidCallback>.from(widget.actions);
    if (widget.onSubmit != null && !effectiveActions.containsKey('submit')) {
      effectiveActions['submit'] = () {
        widget.onSubmit!(_formState.nestedValues);
      };
    }

    // Create the component factory with form state
    final factory = ComponentFactory(
      formState: _formState,
      actions: effectiveActions,
      onApiAction: callApi,
    );

    // Build the screen based on the template
    return Stack(
      children: [
        _buildTemplate(_currentConfig!, factory),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );
  }

  /// Build the screen using the appropriate template
  Widget _buildTemplate(ScreenConfig config, ComponentFactory factory) {
    switch (config.template.toLowerCase()) {
      case 'screen_layout':
        return _buildScreenLayout(config, factory);
      case 'landing':
        return _buildLandingScreen(config, factory);
      default:
        return DynamicScreen._buildError(
            'Unknown template: ${config.template}');
    }
  }

  /// Build a screen using the ScreenLayoutEAE template
  Widget _buildScreenLayout(ScreenConfig config, ComponentFactory factory) {
    // Build header widget if provided
    Widget? topBar;
    if (config.header != null && config.header!.isNotEmpty) {
      if (config.header!.length == 1) {
        topBar = factory.build(config.header!.first);
      } else {
        // Wrap multiple header components in a Column
        topBar = Column(
          mainAxisSize: MainAxisSize.min,
          children: config.header!.map((comp) => factory.build(comp)).toList(),
        );
      }
    }

    // Build content widget (required)
    Widget content;
    if (config.content.length == 1) {
      content = factory.build(config.content.first);
    } else {
      // Wrap multiple content components in a Column
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
        // Wrap multiple footer components in a Column
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

  /// Build a screen using the LandingScreenEAE template
  Widget _buildLandingScreen(ScreenConfig config, ComponentFactory factory) {
    // Get landing screen specific props
    final brandString = LandingScreenProps.getBrand(config);
    final backgroundImageMobile =
        LandingScreenProps.getBackgroundImageMobile(config);
    final backgroundImageDesktop =
        LandingScreenProps.getBackgroundImageDesktop(config);
    final mobileLogoTypeString = LandingScreenProps.getMobileLogoType(config);
    final desktopLogoTypeString = LandingScreenProps.getDesktopLogoType(config);
    final mobileLogoHeight = LandingScreenProps.getMobileLogoHeight(config);
    final desktopLogoHeight = LandingScreenProps.getDesktopLogoHeight(config);
    final topBarButtonText = LandingScreenProps.getTopBarButtonText(config);
    final topBarButtonAction = LandingScreenProps.getTopBarButtonAction(config);

    // Parse brand (required)
    final brand = _parseBrand(brandString);
    if (brand == null) {
      return DynamicScreen._buildError(
          'Brand is required for landing template. Use: match, meetic, okc, or pof');
    }

    // Parse logo types
    final mobileLogoType =
        _parseLogoType(mobileLogoTypeString) ?? LogoTypeEAE.onDark;
    final desktopLogoType =
        _parseLogoType(desktopLogoTypeString) ?? LogoTypeEAE.small;

    // Build content widget
    Widget content;
    if (config.content.length == 1) {
      content = factory.build(config.content.first);
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: config.content.map((comp) => factory.build(comp)).toList(),
      );
    }

    // Build footer widget if provided (for mobile bottom bar)
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

    // Build action callback for top bar button
    VoidCallback? onTopBarButtonPressed;
    if (topBarButtonAction != null) {
      // Check if there's a custom action or use submit
      final effectiveActions = Map<String, VoidCallback>.from(widget.actions);
      if (widget.onSubmit != null && !effectiveActions.containsKey('submit')) {
        effectiveActions['submit'] = () {
          widget.onSubmit!(_formState.nestedValues);
        };
      }
      onTopBarButtonPressed = effectiveActions[topBarButtonAction];
    }

    // Parse image providers (support both assets and network URLs)
    ImageProvider? mobileImage;
    if (backgroundImageMobile != null) {
      mobileImage = backgroundImageMobile.startsWith('http')
          ? NetworkImage(backgroundImageMobile) as ImageProvider
          : AssetImage(backgroundImageMobile) as ImageProvider;
    }

    ImageProvider? desktopImage;
    if (backgroundImageDesktop != null) {
      desktopImage = backgroundImageDesktop.startsWith('http')
          ? NetworkImage(backgroundImageDesktop) as ImageProvider
          : AssetImage(backgroundImageDesktop) as ImageProvider;
    }

    return LandingScreenEAE(
      config: LandingScreenConfig(
        brand: brand,
        backgroundImageMobile: mobileImage,
        backgroundImageDesktop: desktopImage,
        mobileLogoType: mobileLogoType,
        desktopLogoType: desktopLogoType,
        mobileLogoHeight: mobileLogoHeight,
        desktopLogoHeight: desktopLogoHeight,
        topBarButtonText: topBarButtonText,
        onTopBarButtonPressed: onTopBarButtonPressed,
      ),
      content: content,
      bottomBar: bottomBar,
    );
  }

  /// Parse brand from string
  static Brand? _parseBrand(String? brandString) {
    if (brandString == null) return null;
    return switch (brandString.toLowerCase()) {
      'match' => Brand.match,
      'meetic' => Brand.meetic,
      'okc' || 'okcupid' => Brand.okc,
      'pof' || 'plentyoffish' => Brand.pof,
      _ => null,
    };
  }

  /// Parse logo type from string
  static LogoTypeEAE? _parseLogoType(String? logoTypeString) {
    if (logoTypeString == null) return null;
    return switch (logoTypeString.toLowerCase()) {
      'small' => LogoTypeEAE.small,
      'ondark' => LogoTypeEAE.onDark,
      'onwhite' => LogoTypeEAE.onWhite,
      _ => null,
    };
  }

  /// Parse color from string (hex format)
  static Color? _parseColor(String colorString) {
    if (colorString.startsWith('#')) {
      final hexCode = colorString.substring(1);
      if (hexCode.length == 6) {
        return Color(int.parse('FF$hexCode', radix: 16));
      } else if (hexCode.length == 8) {
        return Color(int.parse(hexCode, radix: 16));
      }
    }
    return null;
  }
}
