import 'package:flutter/material.dart';
import '../brand_config.dart';

class PofBrand implements BrandConfig {
  @override
  String get name => 'Plenty of Fish';

  @override
  BrandColorsConfig get colors => const BrandColorsConfig(
        primary: Color(0xFF000000),
        secondary: Color(0xFF4ECDC4),
        background: Color(0xFFFFFFFF),
        surface: Color(0xFFFFF5F0),
      );

  @override
  BrandButtonConfig get buttonConfig => const BrandButtonConfig(
        borderRadius: 999.0, // Capsule shape
      );

  @override
  BrandSelectableButtonConfig get selectableButtonConfig =>
      const BrandSelectableButtonConfig(
        // Unselected State
        unselectedBorderColor: Colors.black,
        unselectedTextColor: Colors.black,
        unselectedBackgroundColor: Colors.transparent,
        unselectedBorderWidth: 2.0,

        // Selected State
        selectedBackgroundColor:
            Color(0xFFFF9E80), // Salmon/Coral color for selected state
        selectedForegroundColor: Colors.black,
        selectedBorderColor: Colors.black,
        selectedBorderWidth: 3.0, // Even thicker border when selected
      );

  @override
  BrandCheckboxConfig get checkboxConfig => const BrandCheckboxConfig(
        activeColor: Colors.black,
        checkColor: Colors.black,
        backgroundColor: Color(0xFFFF9E80), // Salmon background
        borderRadius: 8.0, // Rounded
        borderWidth: 2.0, // Thin when unselected
        selectedBorderWidth: 3.0, // Thick when selected
        checkStrokeWidth: 3.0, // Thick check
      );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
        unselectedBorderColor: Colors.black,
        selectedBorderColor: Colors.black,
        selectedBackgroundColor: Color(0xFFFF9E80), // Salmon Fill
        dotColor: Colors.black, // Black Dot
        borderWidth: 2.0, // Thick border
      );

  @override
  BrandInputConfig get inputConfig => const BrandInputConfig(
        borderType: BrandInputBorderType.outline,
        filled: true,
        fillColor: Color(0xFFFFF5F0), // Light salmon/peach background
        borderRadius: 999.0, // Full capsule shape
        activeBorderColor: Color(0xFF555555), // Dark grey border
        inactiveBorderColor: Color(0xFF555555), // Dark grey border
        textColor: Color(0xFF000000), // Solid black text for input
        textFontWeight: FontWeight.w600, // Semi-bold text for input
        labelColor: Color(0xFF555555), // Dark grey label
        hintColor: Color(0xFF555555), // Dark grey hint
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      );

  @override
  BrandToggleConfig get toggleConfig => const BrandToggleConfig(
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.black,
        activeKnobColor: Colors.white,
        inactiveKnobColor: Colors.white,
        trackWidth: 50.0,
        trackHeight: 28.0,
        knobSize: 22.0,
      );

  @override
  BrandLinkedTextConfig get linkedTextConfig => const BrandLinkedTextConfig(
        normalTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        linkTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        linkUnderlineThickness: 1.0,
        linkUnderlineOffset: 3.0,
      );

  @override
  BrandLabeledControlConfig get labeledControlConfig =>
      const BrandLabeledControlConfig(
        checkboxLabelPaddingTop: 4.0,
        toggleLabelPaddingTop: 6.0,
      );

  @override
  BrandSliderConfig get sliderConfig => const BrandSliderConfig(
        activeTrackColor: Colors.black, // Piste active noire
        inactiveTrackColor: Color(0xFFE0E0E0), // Piste inactive grise
        thumbColor: Colors.white, // Curseur blanc
        overlayColor: Color(0x1F000000), // Noir transparent pour l'effet
        trackHeight: 2.0, // Piste fine pour POF
        thumbRadius: 16.0, // Curseur plus grand
        overlayRadius: 24.0,
        thumbBorderWidth: 2.0, // Bordure fine comme la ligne
        thumbBorderColor:
            Color(0xFFE0E0E0), // Bordure grise comme la ligne inactive
      );

  @override
  BrandTypographyConfig get typographyConfig => const BrandTypographyConfig(
        headlineFontFamily: 'Spectral', // Serif moderne pour h1, h2
        headlineSmallFontFamily: 'DM Sans', // Sans-serif pour h3
        titleFontFamily: 'Spectral',
        headlineFontWeight: FontWeight.w500, // Medium pour h1
        headlineMediumFontWeight: FontWeight.w300, // Light pour h2
        headlineSmallFontWeight: FontWeight.w400, // Regular pour h3
        headlineSmallFontSize: 20, // Taille plus petite pour h3
        titleFontWeight: FontWeight.w400,
        headlineColor: Colors.black, // Noir
        titleColor: Colors.black,
      );

  @override
  BrandSelectionGroupConfig get selectionGroupConfig =>
      const BrandSelectionGroupConfig(
        showDividers: false,
        showCard: false, // Pas de carte pour POF
        cardBackgroundColor: Colors.transparent,
      );

  @override
  BrandTagConfig get tagConfig => const BrandTagConfig(
        // Mode lecture seule : fond blanc avec bordure grise (comme dans l'image)
        readOnlyBackgroundColor: Colors.white,
        readOnlyForegroundColor: Colors.black,
        readOnlyBorderColor: Color(0xFFD1D1D6), // Bordure grise

        // Mode sélectionnable - état non sélectionné
        unselectedBackgroundColor: Colors.white,
        unselectedForegroundColor: Color(0xFF8E8E93), // Gris moyen
        unselectedBorderColor: Color(0xFFD1D1D6), // Bordure grise

        // Mode sélectionnable - état sélectionné
        selectedBackgroundColor: Colors.black, // Fond noir POF
        selectedForegroundColor: Colors.white,
        selectedBorderColor: Colors.black,
      );

  @override
  BrandProgressBarConfig get progressBarConfig => const BrandProgressBarConfig(
        activeColor: Colors.black, // Noir POF
        inactiveColor: Color(0xFFE0E0E0), // Gris clair
        counterTextColor: Colors.black, // Noir
        height: 8.0,
        borderRadius: 4.0,
      );

  @override
  BrandScreenLayoutConfig get screenLayoutConfig =>
      const BrandScreenLayoutConfig(
        dividerColor:
            Color(0xFFE0E0E0), // Gris clair pour la ligne de séparation
        dividerThickness: 1.0,
        scrollGradientColor: Color(0xFF000000), // Noir pour le dégradé
        scrollGradientHeight: 16.0,
      );

  @override
  BrandLandingScreenConfig get landingScreenConfig =>
      const BrandLandingScreenConfig(
        mobileLogoAlignment: LandingLogoAlignment.left,
        mobileLogoPaddingTop: 48.0,
        mobileLogoPaddingBottom: 24.0,
        mobileLogoPaddingHorizontal: 20.0,
        mobileBackgroundColor:
            Color(0xFFFFA18D), // Couleur saumon POF (pas d'image en mobile)
        desktopCardMaxWidth: 440.0,
        desktopTopBarHeight: 84.0,
        desktopTopBarPaddingHorizontal: 24.0,
        desktopTopBarBackgroundColor: Colors.white,
        desktopTopBarBoxShadow: BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8.0,
          offset: Offset(0, 2),
        ),
        desktopCardBorderRadius: 12.0,
        desktopCardElevation: 8.0,
        desktopCardPadding: EdgeInsets.all(32.0),
        mobileBreakpoint: 600.0,
      );

  @override
  BrandLogoConfig get logoConfig => const BrandLogoConfig(
        smallHeight: 60.0,
        largeHeight: 60.0,
      );
}
