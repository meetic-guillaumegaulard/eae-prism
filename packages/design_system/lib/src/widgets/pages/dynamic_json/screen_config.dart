import 'component_config.dart';

/// Configuration for a dynamic screen layout
class ScreenConfig {
  /// Template type to use (e.g., 'screen_layout', 'landing')
  final String template;

  /// Configuration for the top bar/header
  final List<ComponentConfig>? header;

  /// Configuration for the main content
  final List<ComponentConfig> content;

  /// Configuration for the bottom bar/footer
  final List<ComponentConfig>? footer;

  /// Additional screen-level properties (e.g., backgroundColor)
  final Map<String, dynamic> props;

  const ScreenConfig({
    required this.template,
    this.header,
    required this.content,
    this.footer,
    this.props = const {},
  });

  /// Create a ScreenConfig from a JSON map
  factory ScreenConfig.fromJson(Map<String, dynamic> json) {
    return ScreenConfig(
      template: json['template'] as String? ?? 'screen_layout',
      header: json['header'] != null
          ? (json['header'] as List)
              .map((comp) => ComponentConfig.fromJson(comp as Map<String, dynamic>))
              .toList()
          : null,
      content: (json['content'] as List)
          .map((comp) => ComponentConfig.fromJson(comp as Map<String, dynamic>))
          .toList(),
      footer: json['footer'] != null
          ? (json['footer'] as List)
              .map((comp) => ComponentConfig.fromJson(comp as Map<String, dynamic>))
              .toList()
          : null,
      props: json['props'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'template': template,
      if (header != null) 'header': header!.map((comp) => comp.toJson()).toList(),
      'content': content.map((comp) => comp.toJson()).toList(),
      if (footer != null) 'footer': footer!.map((comp) => comp.toJson()).toList(),
      'props': props,
    };
  }

  /// Helper to get a screen-level prop value
  T? getProp<T>(String key, {T? defaultValue}) {
    final value = props[key];
    if (value == null) return defaultValue;
    if (value is T) return value;
    return defaultValue;
  }
}

/// Configuration spécifique pour le template landing
/// 
/// Props supportés:
/// - brand: String (match, meetic, okc, pof) - requis
/// - backgroundImageMobile: String (chemin de l'asset ou URL)
/// - backgroundImageDesktop: String (chemin de l'asset ou URL)
/// - mobileLogoType: String (small, onDark, onWhite) - défaut: onDark
/// - desktopLogoType: String (small, onDark, onWhite) - défaut: small
/// - mobileLogoHeight: double (optionnel)
/// - desktopLogoHeight: double (optionnel)
/// - topBarButtonText: String (texte du bouton dans le bandeau desktop)
/// - topBarButtonAction: String (nom de l'action à appeler)
class LandingScreenProps {
  static String? getBrand(ScreenConfig config) =>
      config.getProp<String>('brand');

  static String? getBackgroundImageMobile(ScreenConfig config) =>
      config.getProp<String>('backgroundImageMobile');
      
  static String? getBackgroundImageDesktop(ScreenConfig config) =>
      config.getProp<String>('backgroundImageDesktop');

  static String? getMobileLogoType(ScreenConfig config) =>
      config.getProp<String>('mobileLogoType');

  static String? getDesktopLogoType(ScreenConfig config) =>
      config.getProp<String>('desktopLogoType');

  static double? getMobileLogoHeight(ScreenConfig config) =>
      config.getProp<num>('mobileLogoHeight')?.toDouble();

  static double? getDesktopLogoHeight(ScreenConfig config) =>
      config.getProp<num>('desktopLogoHeight')?.toDouble();
      
  static String? getTopBarButtonText(ScreenConfig config) =>
      config.getProp<String>('topBarButtonText');
      
  static String? getTopBarButtonAction(ScreenConfig config) =>
      config.getProp<String>('topBarButtonAction');
}

