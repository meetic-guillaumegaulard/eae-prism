import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen_config.dart';
import 'component_factory.dart';
import 'form_state_manager.dart';
import '../../templates/screen_layout_eae.dart';
import '../../templates/landing_screen_eae.dart';
import '../../../models/brand.dart';
import '../../atoms/logo_eae.dart';

/// Widget that builds a screen dynamically from JSON configuration
/// Form values are automatically collected and accessible via [formValues]
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
  /// If provided, automatically adds a "submit" action
  final ValueChanged<Map<String, dynamic>>? onSubmit;

  const DynamicScreen({
    Key? key,
    this.jsonString,
    this.config,
    this.actions = const {},
    this.onFormChanged,
    this.onSubmit,
  })  : assert(
          jsonString != null || config != null,
          'Either jsonString or config must be provided',
        ),
        super(key: key);

  /// Create a DynamicScreen from an asset file
  static Widget fromAsset(
    String assetPath, {
    Map<String, VoidCallback> actions = const {},
    ValueChanged<Map<String, dynamic>>? onFormChanged,
    ValueChanged<Map<String, dynamic>>? onSubmit,
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
  ScreenConfig? _parsedConfig;
  String? _error;

  /// Get the current form values as a flat map
  Map<String, dynamic> get formValues => _formState.values;

  /// Get the current form values as a nested JSON structure
  Map<String, dynamic> get nestedFormValues => _formState.nestedValues;

  @override
  void initState() {
    super.initState();
    _formState = FormStateManager();
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
        _parsedConfig = widget.config;
        _error = null;
      } else if (widget.jsonString != null) {
        final Map<String, dynamic> json = jsonDecode(widget.jsonString!);
        _parsedConfig = ScreenConfig.fromJson(json);
        _error = null;
      }
    } catch (e) {
      _error = 'Error parsing config: $e';
      _parsedConfig = null;
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
    _formState.setValues(values);
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return DynamicScreen._buildError(_error!);
    }

    if (_parsedConfig == null) {
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
    );

    // Build the screen based on the template
    return _buildTemplate(_parsedConfig!, factory);
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
    final mobileLogoType = _parseLogoType(mobileLogoTypeString) ?? LogoTypeEAE.onDark;
    final desktopLogoType = _parseLogoType(desktopLogoTypeString) ?? LogoTypeEAE.small;

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
