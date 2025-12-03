import 'package:flutter/material.dart';
import 'match/match_brand.dart';
import 'meetic/meetic_brand.dart';
import 'okc/okc_brand.dart';
import 'pof/pof_brand.dart';
import '../models/brand.dart';

abstract class BrandConfig {
  String get name;
  BrandColorsConfig get colors;
  BrandButtonConfig get buttonConfig;
  BrandSelectableButtonConfig get selectableButtonConfig;
  BrandCheckboxConfig get checkboxConfig;
  BrandRadioButtonConfig get radioButtonConfig;
  BrandInputConfig get inputConfig;
  BrandToggleConfig get toggleConfig;
  BrandLinkedTextConfig get linkedTextConfig;
  BrandLabeledControlConfig get labeledControlConfig;
  BrandSliderConfig get sliderConfig;
  BrandTypographyConfig get typographyConfig;
  BrandSelectionGroupConfig get selectionGroupConfig;
  BrandTagConfig get tagConfig;
  BrandProgressBarConfig get progressBarConfig;
  BrandScreenLayoutConfig get screenLayoutConfig;
  BrandLandingScreenConfig get landingScreenConfig;
  BrandLogoConfig get logoConfig;

  static BrandConfig fromBrand(Brand brand) {
    switch (brand) {
      case Brand.match:
        return MatchBrand();
      case Brand.meetic:
        return MeeticBrand();
      case Brand.okc:
        return OkcBrand();
      case Brand.pof:
        return PofBrand();
    }
  }
}

class BrandColorsConfig {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;

  const BrandColorsConfig({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
  });
}

class BrandButtonConfig {
  final double borderRadius;
  final double elevation;
  final Color? shadowColor;
  final double? horizontalPadding; // Override default padding if set
  final double?
      verticalPadding; // Override default vertical padding (and remove fixed height)
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final double? outlineElevation; // Elevation for outline variant (null = use elevation)

  const BrandButtonConfig({
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.outlineElevation,
  });
}

class BrandSelectableButtonConfig {
  // Unselected State
  final Color? unselectedBorderColor;
  final Color? unselectedTextColor;
  final Color? unselectedBackgroundColor;
  final double unselectedBorderWidth;

  // Selected State
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBorderColor;
  final double selectedBorderWidth;
  final bool showRadioButton;
  final double? horizontalPadding;
  final double? verticalPadding;

  const BrandSelectableButtonConfig({
    this.unselectedBorderColor,
    this.unselectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedBorderWidth = 1.0,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedBorderColor,
    this.selectedBorderWidth = 0.0,
    this.showRadioButton = false,
    this.horizontalPadding,
    this.verticalPadding,
  });
}

class BrandCheckboxConfig {
  final Color activeColor;
  final Color? checkColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double borderWidth; // Unselected border width
  final double
      selectedBorderWidth; // Selected border width (defaults to borderWidth if null)
  final double checkStrokeWidth;

  const BrandCheckboxConfig({
    required this.activeColor,
    this.checkColor,
    this.backgroundColor,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    double? selectedBorderWidth,
    this.checkStrokeWidth = 2.0,
  }) : selectedBorderWidth = selectedBorderWidth ?? borderWidth;
}

class BrandRadioButtonConfig {
  final Color unselectedBorderColor;
  final Color selectedBorderColor;
  final Color
      selectedBackgroundColor; // Background of the outer circle when selected
  final Color dotColor; // Color of the inner dot
  final double borderWidth;

  const BrandRadioButtonConfig({
    required this.unselectedBorderColor,
    required this.selectedBorderColor,
    required this.selectedBackgroundColor,
    required this.dotColor,
    this.borderWidth = 2.0,
  });
}

enum BrandInputBorderType {
  underline,
  outline,
  none,
}

class BrandInputConfig {
  final BrandInputBorderType borderType;
  final bool filled;
  final Color? fillColor;
  final double borderRadius;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? errorFillColor;
  final double errorFontSize;
  final FontWeight errorFontWeight;
  final FontWeight? textFontWeight;
  final bool floatingLabel;
  final EdgeInsetsGeometry? labelPadding;

  const BrandInputConfig({
    this.borderType = BrandInputBorderType.outline,
    this.filled = false,
    this.fillColor,
    this.borderRadius = 4.0,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.contentPadding,
    this.errorFillColor,
    this.errorFontSize = 12.0,
    this.errorFontWeight = FontWeight.normal,
    this.textFontWeight,
    this.floatingLabel = true,
    this.labelPadding,
  });
}

class BrandToggleConfig {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeKnobColor;
  final Color inactiveKnobColor;
  final double trackWidth;
  final double trackHeight;
  final double knobSize;
  final double borderWidth;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;

  const BrandToggleConfig({
    required this.activeTrackColor,
    this.inactiveTrackColor = const Color(0xFFE0E0E0),
    this.activeKnobColor = const Color(0xFFFFFFFF),
    this.inactiveKnobColor = const Color(0xFFFFFFFF),
    this.trackWidth = 52.0,
    this.trackHeight = 32.0,
    this.knobSize = 28.0,
    this.borderWidth = 0.0,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });
}

class BrandLinkedTextConfig {
  final TextStyle normalTextStyle;
  final TextStyle linkTextStyle;
  final double linkUnderlineThickness;
  final double linkUnderlineOffset;

  const BrandLinkedTextConfig({
    required this.normalTextStyle,
    required this.linkTextStyle,
    this.linkUnderlineThickness = 1.0,
    this.linkUnderlineOffset = 1.0,
  });
}

class BrandLabeledControlConfig {
  final double checkboxLabelPaddingTop;
  final double toggleLabelPaddingTop;

  const BrandLabeledControlConfig({
    this.checkboxLabelPaddingTop = 0.0,
    this.toggleLabelPaddingTop = 0.0,
  });
}

class BrandSliderConfig {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final Color? overlayColor;
  final double trackHeight;
  final double thumbRadius;
  final double overlayRadius;
  final double thumbElevation;
  final Color? thumbShadowColor;
  final double thumbBorderWidth;
  final Color? thumbBorderColor;

  const BrandSliderConfig({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.overlayColor,
    this.trackHeight = 4.0,
    this.thumbRadius = 10.0,
    this.overlayRadius = 20.0,
    this.thumbElevation = 0.0,
    this.thumbShadowColor,
    this.thumbBorderWidth = 0.0,
    this.thumbBorderColor,
  });
}

class BrandTypographyConfig {
  /// Font family for headlines (h1, h2, h3)
  final String? headlineFontFamily;

  /// Font family specifically for h3 (headlineSmall) - overrides headlineFontFamily if set
  final String? headlineSmallFontFamily;

  /// Font family for titles (h4, h5, h6)
  final String? titleFontFamily;

  /// Font family for body text
  final String? bodyFontFamily;

  /// Font family for labels
  final String? labelFontFamily;

  /// Font weight for headlines (h1, h2, h3)
  final FontWeight? headlineFontWeight;

  /// Font weight specifically for h2 (headlineMedium) - overrides headlineFontWeight if set
  final FontWeight? headlineMediumFontWeight;

  /// Font weight specifically for h3 (headlineSmall) - overrides headlineFontWeight if set
  final FontWeight? headlineSmallFontWeight;

  /// Font weight for titles (h4, h5, h6)
  final FontWeight? titleFontWeight;

  /// Font size specifically for h3 (headlineSmall) - overrides default if set
  final double? headlineSmallFontSize;

  /// Color for headlines (h1, h2, h3)
  final Color? headlineColor;

  /// Color for titles (h4, h5, h6)
  final Color? titleColor;

  const BrandTypographyConfig({
    this.headlineFontFamily,
    this.headlineSmallFontFamily,
    this.titleFontFamily,
    this.bodyFontFamily,
    this.labelFontFamily,
    this.headlineFontWeight,
    this.headlineMediumFontWeight,
    this.headlineSmallFontWeight,
    this.headlineSmallFontSize,
    this.titleFontWeight,
    this.headlineColor,
    this.titleColor,
  });
}

class BrandSelectionGroupConfig {
  final bool showDividers;
  final Color? dividerColor;
  final double dividerThickness;
  final double dividerIndent;
  final bool showCard;
  final Color? cardBackgroundColor;

  const BrandSelectionGroupConfig({
    this.showDividers = false,
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.dividerIndent = 0.0,
    this.showCard = false,
    this.cardBackgroundColor,
  });
}

class BrandTagConfig {
  // Couleurs pour le mode lecture seule
  final Color? readOnlyBackgroundColor;
  final Color? readOnlyForegroundColor;
  final Color? readOnlyBorderColor;

  // Couleurs pour le mode sélectionnable - état non sélectionné
  final Color? unselectedBackgroundColor;
  final Color? unselectedForegroundColor;
  final Color? unselectedBorderColor;

  // Couleurs pour le mode sélectionnable - état sélectionné
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBorderColor;

  // Hauteur fixe pour les tags sélectionnables (si null, utilise le padding par défaut)
  final double? selectableHeight;

  const BrandTagConfig({
    this.readOnlyBackgroundColor,
    this.readOnlyForegroundColor,
    this.readOnlyBorderColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.unselectedBorderColor,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedBorderColor,
    this.selectableHeight,
  });
}

class BrandProgressBarConfig {
  final Color? activeColor;
  final Gradient? activeGradient;
  final Color? inactiveColor;
  final Color? counterTextColor;
  final double height;
  final double borderRadius;

  const BrandProgressBarConfig({
    this.activeColor,
    this.activeGradient,
    this.inactiveColor,
    this.counterTextColor,
    this.height = 8.0,
    this.borderRadius = 4.0,
  });
}

class BrandScreenLayoutConfig {
  /// Couleur de la ligne de séparation entre le header/footer et le contenu
  final Color? dividerColor;
  
  /// Épaisseur de la ligne de séparation
  final double dividerThickness;
  
  /// Couleur du dégradé indiquant qu'il est possible de scroller
  final Color? scrollGradientColor;
  
  /// Hauteur du dégradé de scroll
  final double scrollGradientHeight;

  const BrandScreenLayoutConfig({
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.scrollGradientColor,
    this.scrollGradientHeight = 16.0,
  });
}

/// Alignement horizontal pour le logo
enum LandingLogoAlignment {
  left,
  center,
  right,
}

/// Configuration pour les logos de la marque
class BrandLogoConfig {
  /// Hauteur par défaut du logo small (compact)
  final double smallHeight;

  /// Hauteur par défaut des logos large (onDark, onWhite)
  final double largeHeight;

  const BrandLogoConfig({
    this.smallHeight = 60.0,
    this.largeHeight = 60.0,
  });
}

/// Configuration pour le template landing screen
class BrandLandingScreenConfig {
  /// Alignement du logo large en mode mobile
  final LandingLogoAlignment mobileLogoAlignment;
  
  /// Padding en haut du logo en mode mobile
  final double mobileLogoPaddingTop;
  
  /// Padding en bas du logo en mode mobile
  final double mobileLogoPaddingBottom;
  
  /// Padding horizontal du logo en mode mobile
  final double mobileLogoPaddingHorizontal;
  
  /// Couleur de fond en mode mobile (utilisée si pas d'image de fond)
  final Color? mobileBackgroundColor;
  
  /// Largeur maximale de la carte en mode desktop
  final double desktopCardMaxWidth;
  
  /// Hauteur du bandeau en mode desktop
  final double desktopTopBarHeight;
  
  /// Padding horizontal du bandeau desktop
  final double desktopTopBarPaddingHorizontal;
  
  /// Padding vertical du bandeau desktop
  final double desktopTopBarPaddingVertical;
  
  /// Couleur de fond du bandeau desktop (null = transparent)
  final Color? desktopTopBarBackgroundColor;
  
  /// Ombre du bandeau desktop (null = pas d'ombre)
  final BoxShadow? desktopTopBarBoxShadow;
  
  /// Couleur de fond de la carte desktop
  final Color? desktopCardBackgroundColor;
  
  /// Rayon des coins de la carte desktop
  final double desktopCardBorderRadius;
  
  /// Élévation (ombre) de la carte desktop
  final double desktopCardElevation;
  
  /// Padding intérieur de la carte desktop
  final EdgeInsets desktopCardPadding;
  
  /// Breakpoint pour passer du mode mobile au desktop
  final double mobileBreakpoint;

  const BrandLandingScreenConfig({
    this.mobileLogoAlignment = LandingLogoAlignment.center,
    this.mobileLogoPaddingTop = 60.0,
    this.mobileLogoPaddingBottom = 32.0,
    this.mobileLogoPaddingHorizontal = 24.0,
    this.mobileBackgroundColor,
    this.desktopCardMaxWidth = 480.0,
    this.desktopTopBarHeight = 64.0,
    this.desktopTopBarPaddingHorizontal = 24.0,
    this.desktopTopBarPaddingVertical = 12.0,
    this.desktopTopBarBackgroundColor,
    this.desktopTopBarBoxShadow,
    this.desktopCardBackgroundColor,
    this.desktopCardBorderRadius = 16.0,
    this.desktopCardElevation = 8.0,
    this.desktopCardPadding = const EdgeInsets.all(32.0),
    this.mobileBreakpoint = 600.0,
  });
}
