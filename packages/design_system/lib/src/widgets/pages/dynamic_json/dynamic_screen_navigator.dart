import 'package:flutter/material.dart';
import 'navigation_response.dart';
import 'screen_config.dart';
import 'component_config.dart';
import 'component_factory.dart';
import 'form_state_manager.dart';
import '../../templates/screen_layout_eae.dart';
import '../../templates/landing_screen_eae.dart';
import '../../../models/brand.dart';
import '../../atoms/logo_eae.dart';
import '../../../utils/api_utils.dart';

/// Callback appelé quand une action API est déclenchée
typedef OnApiAction = void Function(String endpoint, Map<String, dynamic> data);

/// Widget qui gère la navigation dynamique entre écrans avec animations
class DynamicScreenNavigator extends StatefulWidget {
  /// Configuration initiale de l'écran
  final ScreenConfig initialConfig;

  /// URL de base de l'API (optionnel, utilise ApiUtils.baseUrl par défaut)
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

  const DynamicScreenNavigator({
    super.key,
    required this.initialConfig,
    this.baseUrl,
    this.actions = const {},
    this.onFormChanged,
    this.onSubmit,
    this.onApiError,
    this.onApiRequest,
  });

  @override
  State<DynamicScreenNavigator> createState() => DynamicScreenNavigatorState();
}

class DynamicScreenNavigatorState extends State<DynamicScreenNavigator>
    with TickerProviderStateMixin {
  late FormStateManager _formState;
  late ScreenConfig _currentConfig;

  // Animation controllers
  AnimationController? _contentAnimationController;
  AnimationController? _fullAnimationController;
  Animation<Offset>? _outgoingSlide;
  Animation<Offset>? _incomingSlide;

  // État de transition
  bool _isTransitioning = false;
  ScreenConfig? _nextConfig;
  NavigationConfig? _currentNavigation;

  // Pour les transitions content-only
  bool _headerChanged = false;
  bool _footerChanged = false;

  Map<String, dynamic> get formValues => _formState.nestedValues;

  @override
  void initState() {
    super.initState();
    _formState = FormStateManager();
    _formState.addListener(_onFormChanged);
    _currentConfig = widget.initialConfig;
  }

  @override
  void dispose() {
    _formState.removeListener(_onFormChanged);
    _formState.dispose();
    _contentAnimationController?.dispose();
    _fullAnimationController?.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    widget.onFormChanged?.call(_formState.nestedValues);
  }

  /// Appelle l'API avec l'endpoint et les données actuelles du formulaire
  Future<void> callApi(String endpoint) async {
    if (_isTransitioning) return;

    final data = _formState.nestedValues;
    widget.onApiRequest?.call(endpoint, data);

    try {
      final response = await ApiUtils.post(
        endpoint,
        data,
        customBaseUrl: widget.baseUrl,
      );

      final navResponse = NavigationResponse.fromJson(response);
      await _handleNavigation(navResponse);
    } catch (e) {
      widget.onApiError?.call(e);
    }
  }

  /// Gère la navigation en fonction de la réponse du serveur
  Future<void> _handleNavigation(NavigationResponse response) async {
    final nav = response.navigation;

    if (nav.type == NavigationType.refresh) {
      // Simple refresh sans animation
      setState(() {
        _currentConfig = response.screen;
        _formState.clear(); // Reset form pour le nouvel écran
      });
    } else {
      // Navigation avec animation
      await _animateTransition(nav, response.screen);
    }
  }

  /// Anime la transition vers le nouvel écran
  Future<void> _animateTransition(
    NavigationConfig nav,
    ScreenConfig nextScreen,
  ) async {
    final duration = Duration(milliseconds: nav.durationMs);

    // Détermine les offsets de l'animation
    final (outOffset, inOffset) = _getSlideOffsets(nav.direction);

    if (nav.scope == NavigationScope.full) {
      await _animateFullScreen(
        nextScreen,
        duration,
        outOffset,
        inOffset,
      );
    } else {
      await _animateContentOnly(
        nextScreen,
        duration,
        outOffset,
        inOffset,
      );
    }
  }

  /// Retourne les offsets pour les animations d'entrée/sortie
  (Offset, Offset) _getSlideOffsets(NavigationDirection direction) {
    return switch (direction) {
      NavigationDirection.left => (const Offset(-1, 0), const Offset(1, 0)),
      NavigationDirection.right => (const Offset(1, 0), const Offset(-1, 0)),
      NavigationDirection.up => (const Offset(0, -1), const Offset(0, 1)),
      NavigationDirection.down => (const Offset(0, 1), const Offset(0, -1)),
    };
  }

  /// Animation sur tout l'écran
  Future<void> _animateFullScreen(
    ScreenConfig nextScreen,
    Duration duration,
    Offset outOffset,
    Offset inOffset,
  ) async {
    _fullAnimationController?.dispose();
    _fullAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _outgoingSlide = Tween<Offset>(
      begin: Offset.zero,
      end: outOffset,
    ).animate(CurvedAnimation(
      parent: _fullAnimationController!,
      curve: Curves.easeInOut,
    ));

    _incomingSlide = Tween<Offset>(
      begin: inOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _fullAnimationController!,
      curve: Curves.easeInOut,
    ));

    setState(() {
      _isTransitioning = true;
      _nextConfig = nextScreen;
      _currentNavigation = NavigationConfig(
        type: NavigationType.navigate,
        scope: NavigationScope.full,
      );
    });

    await _fullAnimationController!.forward();

    setState(() {
      _currentConfig = nextScreen;
      _isTransitioning = false;
      _nextConfig = null;
      _currentNavigation = null;
      _formState.clear();
    });
  }

  /// Animation uniquement sur le contenu, bandeaux fixes
  Future<void> _animateContentOnly(
    ScreenConfig nextScreen,
    Duration duration,
    Offset outOffset,
    Offset inOffset,
  ) async {
    _contentAnimationController?.dispose();
    _contentAnimationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    _outgoingSlide = Tween<Offset>(
      begin: Offset.zero,
      end: outOffset,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController!,
      curve: Curves.easeInOut,
    ));

    _incomingSlide = Tween<Offset>(
      begin: inOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController!,
      curve: Curves.easeInOut,
    ));

    // Vérifie si les bandeaux ont changé
    _headerChanged = !_areConfigsEqual(
      _currentConfig.header,
      nextScreen.header,
    );
    _footerChanged = !_areConfigsEqual(
      _currentConfig.footer,
      nextScreen.footer,
    );

    setState(() {
      _isTransitioning = true;
      _nextConfig = nextScreen;
      _currentNavigation = NavigationConfig(
        type: NavigationType.navigate,
        scope: NavigationScope.content,
      );
      // Mise à jour instantanée des bandeaux s'ils ont changé
      if (_headerChanged || _footerChanged) {
        // Les bandeaux seront reconstruits avec la nouvelle config
      }
    });

    await _contentAnimationController!.forward();

    setState(() {
      _currentConfig = nextScreen;
      _isTransitioning = false;
      _nextConfig = null;
      _currentNavigation = null;
      _headerChanged = false;
      _footerChanged = false;
      _formState.clear();
    });
  }

  /// Compare deux listes de ComponentConfig
  bool _areConfigsEqual(
    List<ComponentConfig>? a,
    List<ComponentConfig>? b,
  ) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    // Comparaison simple par sérialisation JSON
    for (var i = 0; i < a.length; i++) {
      if (a[i].toJson().toString() != b[i].toJson().toString()) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final factory = _createFactory();

    if (!_isTransitioning) {
      return _buildScreen(_currentConfig, factory);
    }

    // En transition
    if (_currentNavigation?.scope == NavigationScope.full) {
      return _buildFullTransition(factory);
    } else {
      return _buildContentTransition(factory);
    }
  }

  Map<String, VoidCallback> _buildEffectiveActions() {
    final actions = Map<String, VoidCallback>.from(widget.actions);

    // Ajoute l'action submit si callback fourni
    if (widget.onSubmit != null && !actions.containsKey('submit')) {
      actions['submit'] = () => widget.onSubmit!(_formState.nestedValues);
    }

    return actions;
  }

  ComponentFactory _createFactory({FormStateManager? formState}) {
    return ComponentFactory(
      formState: formState ?? _formState,
      actions: _buildEffectiveActions(),
      onApiAction: callApi,
    );
  }

  Widget _buildScreen(ScreenConfig config, ComponentFactory factory) {
    switch (config.template.toLowerCase()) {
      case 'screen_layout':
        return _buildScreenLayout(config, factory);
      case 'landing':
        return _buildLandingScreen(config, factory);
      default:
        return _buildError('Unknown template: ${config.template}');
    }
  }

  Widget _buildFullTransition(ComponentFactory factory) {
    final currentFactory = _createFactory();
    final nextFactory = _createFactory(formState: FormStateManager());

    return Stack(
      children: [
        // Écran sortant
        SlideTransition(
          position: _outgoingSlide!,
          child: _buildScreen(_currentConfig, currentFactory),
        ),
        // Écran entrant
        SlideTransition(
          position: _incomingSlide!,
          child: _buildScreen(_nextConfig!, nextFactory),
        ),
      ],
    );
  }

  Widget _buildContentTransition(ComponentFactory factory) {
    // Pour les transitions content-only, on utilise les bandeaux du nouvel écran
    // si ils ont changé (changement instantané)
    final headerConfig =
        _headerChanged ? _nextConfig!.header : _currentConfig.header;
    final footerConfig =
        _footerChanged ? _nextConfig!.footer : _currentConfig.footer;

    final currentFactory = _createFactory();

    Widget? topBar;
    if (headerConfig != null && headerConfig.isNotEmpty) {
      topBar = headerConfig.length == 1
          ? currentFactory.build(headerConfig.first)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: headerConfig.map((c) => currentFactory.build(c)).toList(),
            );
    }

    Widget? bottomBar;
    if (footerConfig != null && footerConfig.isNotEmpty) {
      bottomBar = footerConfig.length == 1
          ? currentFactory.build(footerConfig.first)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: footerConfig.map((c) => currentFactory.build(c)).toList(),
            );
    }

    // Contenu animé
    final currentContent = _buildContentWidget(_currentConfig, currentFactory);
    final nextFactory = _createFactory(formState: FormStateManager());
    final nextContent = _buildContentWidget(_nextConfig!, nextFactory);

    final animatedContent = ClipRect(
      child: Stack(
        children: [
          SlideTransition(
            position: _outgoingSlide!,
            child: currentContent,
          ),
          SlideTransition(
            position: _incomingSlide!,
            child: nextContent,
          ),
        ],
      ),
    );

    // Récupère la couleur de fond
    Color? backgroundColor;
    final bgColorString = _currentConfig.getProp<String>('backgroundColor');
    if (bgColorString != null) {
      backgroundColor = _parseColor(bgColorString);
    }

    return ScreenLayoutEAE(
      topBar: topBar,
      content: animatedContent,
      bottomBar: bottomBar,
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildContentWidget(ScreenConfig config, ComponentFactory factory) {
    if (config.content.length == 1) {
      return factory.build(config.content.first);
    }
    return Column(
      children: config.content.map((c) => factory.build(c)).toList(),
    );
  }

  Widget _buildScreenLayout(ScreenConfig config, ComponentFactory factory) {
    Widget? topBar;
    if (config.header != null && config.header!.isNotEmpty) {
      topBar = config.header!.length == 1
          ? factory.build(config.header!.first)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: config.header!.map((c) => factory.build(c)).toList(),
            );
    }

    Widget content;
    if (config.content.length == 1) {
      content = factory.build(config.content.first);
    } else {
      content = Column(
        children: config.content.map((c) => factory.build(c)).toList(),
      );
    }

    Widget? bottomBar;
    if (config.footer != null && config.footer!.isNotEmpty) {
      bottomBar = config.footer!.length == 1
          ? factory.build(config.footer!.first)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: config.footer!.map((c) => factory.build(c)).toList(),
            );
    }

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

    final brand = _parseBrand(brandString);
    if (brand == null) {
      return _buildError(
          'Brand is required for landing template. Use: match, meetic, okc, or pof');
    }

    final mobileLogoType =
        _parseLogoType(mobileLogoTypeString) ?? LogoTypeEAE.onDark;
    final desktopLogoType =
        _parseLogoType(desktopLogoTypeString) ?? LogoTypeEAE.small;

    Widget content;
    if (config.content.length == 1) {
      content = factory.build(config.content.first);
    } else {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: config.content.map((c) => factory.build(c)).toList(),
      );
    }

    Widget? bottomBar;
    if (config.footer != null && config.footer!.isNotEmpty) {
      bottomBar = config.footer!.length == 1
          ? factory.build(config.footer!.first)
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: config.footer!.map((c) => factory.build(c)).toList(),
            );
    }

    VoidCallback? onTopBarButtonPressed;
    if (topBarButtonAction != null) {
      final effectiveActions = _buildEffectiveActions();
      onTopBarButtonPressed = effectiveActions[topBarButtonAction];
    }

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

  static LogoTypeEAE? _parseLogoType(String? logoTypeString) {
    if (logoTypeString == null) return null;
    return switch (logoTypeString.toLowerCase()) {
      'small' => LogoTypeEAE.small,
      'ondark' => LogoTypeEAE.onDark,
      'onwhite' => LogoTypeEAE.onWhite,
      _ => null,
    };
  }

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

  Widget _buildError(String message) {
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

