import 'package:flutter/material.dart';
import '../brand_config.dart';

class OkcBrand implements BrandConfig {
  @override
  String get name => 'OKCupid';

  @override
  BrandColorsConfig get colors => const BrandColorsConfig(
        primary: Color(0xFF0046D5),
        secondary: Color(0xFF002A80),
        background: Color(0xFFFFFFFF),
        surface: Color(0xFFF0F9FF),
      );

  @override
  BrandButtonConfig get buttonConfig => BrandButtonConfig(
        borderRadius: 999.0, // Capsule shape
        elevation: 8.0, // Stronger shadow for OKC
        shadowColor: Colors.black.withOpacity(0.5),
        disabledBackgroundColor: Color(0xFFBDBDBD), // Medium grey for disabled
        disabledForegroundColor: Colors.white, // White text
      );

  @override
  BrandSelectableButtonConfig get selectableButtonConfig =>
      const BrandSelectableButtonConfig(
        showRadioButton: true,
        unselectedBackgroundColor: Colors.white,
        unselectedBorderColor: Color(0xFFE0E0E0),
        unselectedTextColor: Colors.black87,
        unselectedBorderWidth: 1.0,
        selectedBorderColor: Color(0xFFE0E0E0),
        selectedBorderWidth: 1.0,
        selectedBackgroundColor: Colors.white,
        selectedForegroundColor: Colors.black87,
        horizontalPadding: 24.0, // Matches visual reference (pill shape)
        verticalPadding: 24.0, // Increased vertical padding
      );

  @override
  BrandCheckboxConfig get checkboxConfig => const BrandCheckboxConfig(
        activeColor: Color(0xFF0046D5),
        checkColor: Color(0xFF0046D5),
        backgroundColor: Colors.transparent,
        borderRadius: 6.0,
        borderWidth: 2.5,
        checkStrokeWidth: 2.5,
      );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
        unselectedBorderColor: Color(0xFF0046D5),
        selectedBorderColor: Color(0xFF0046D5),
        selectedBackgroundColor: Colors.transparent,
        dotColor: Color(0xFF0046D5),
        borderWidth: 2.0,
      );

  @override
  BrandInputConfig get inputConfig => const BrandInputConfig(
        borderType: BrandInputBorderType.outline,
        filled: true,
        fillColor: Colors.white,
        borderRadius: 8.0,
        activeBorderColor: Color(0xFF0046D5),
        inactiveBorderColor: Color(0xFFE0E0E0),
        floatingLabel: false, // Label stays on top
        labelPadding:
            EdgeInsets.only(bottom: 8.0, left: 0), // External label positioning
      );

  @override
  BrandToggleConfig get toggleConfig => const BrandToggleConfig(
        activeTrackColor: Color(0xFF0046D5),
        inactiveTrackColor: Color(0xFFE0E0E0),
        activeKnobColor: Colors.white,
        inactiveKnobColor: Colors.white,
        trackWidth: 40.0,
        trackHeight: 24.0,
        knobSize: 18.0,
      );

  @override
  BrandLinkedTextConfig get linkedTextConfig => const BrandLinkedTextConfig(
        normalTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.normal,
        ),
        linkTextStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF0046D5),
          fontWeight: FontWeight.w600,
        ),
        linkUnderlineThickness: 1.0,
        linkUnderlineOffset: 1.0,
      );

  @override
  BrandLabeledControlConfig get labeledControlConfig =>
      const BrandLabeledControlConfig(
        checkboxLabelPaddingTop: 4.0,
        toggleLabelPaddingTop: 4.0,
      );

  @override
  BrandSliderConfig get sliderConfig => const BrandSliderConfig(
        activeTrackColor: Color(0xFF0046D5), // Bleu OKC
        inactiveTrackColor: Color(0xFFE0E0E0), // Gris clair
        thumbColor: Colors.white, // Curseur blanc
        overlayColor: Color(0x1F0046D5), // Bleu transparent pour l'effet
        trackHeight: 2.0, // Piste fine comme POF
        thumbRadius: 16.0, // Curseur plus grand
        overlayRadius: 24.0,
        thumbBorderWidth: 2.0, // Bordure fine comme POF
        thumbBorderColor:
            Color(0xFFE0E0E0), // Bordure grise comme la ligne inactive
      );

  @override
  BrandTypographyConfig get typographyConfig => const BrandTypographyConfig(
        headlineFontFamily: 'Montserrat', // Police sans-serif moderne
        titleFontFamily: 'Montserrat',
        headlineFontWeight: FontWeight.w700, // Bold
        titleFontWeight: FontWeight.w700,
        headlineColor: Colors.black, // Noir comme dans l'image
        titleColor: Colors.black,
      );

  @override
  BrandSelectionGroupConfig get selectionGroupConfig =>
      const BrandSelectionGroupConfig(
        showDividers: true,
        dividerColor: Color(0xFFE0E0E0), // Gris clair
        dividerThickness: 1.0,
        dividerIndent: 36.0, // Indent to align with text
        showCard: true, // Carte visible pour OKC
        cardBackgroundColor: Colors.white, // Fond blanc
      );

  @override
  BrandTagConfig get tagConfig => const BrandTagConfig(
        // Mode lecture seule : fond blanc avec bordure grise (similaire à POF)
        readOnlyBackgroundColor: Colors.white,
        readOnlyForegroundColor: Colors.black,
        readOnlyBorderColor: Color(0xFFD1D1D6), // Bordure grise

        // Mode sélectionnable - état non sélectionné
        unselectedBackgroundColor: Colors.white,
        unselectedForegroundColor: Color(0xFF8E8E93), // Gris moyen
        unselectedBorderColor: Color(0xFFD1D1D6), // Bordure grise

        // Mode sélectionnable - état sélectionné
        selectedBackgroundColor: Color(0xFF0046D5), // Bleu OKC
        selectedForegroundColor: Colors.white,
        selectedBorderColor: Color(0xFF0046D5),
      );

  @override
  BrandProgressBarConfig get progressBarConfig => const BrandProgressBarConfig(
        activeColor:
            Color(0xFFB794F6), // Violet/mauve OKC (couleur de la barre active)
        inactiveColor: Color(0xFFF5F5F5), // Gris très clair presque blanc
        counterTextColor: Colors.black, // Noir
        height: 8.0,
        borderRadius: 999.0, // Bords complètement arrondis (capsule)
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
        mobileLogoAlignment: LandingLogoAlignment.center,
        mobileLogoPaddingTop: 60.0,
        mobileLogoPaddingBottom: 32.0,
        mobileLogoPaddingHorizontal: 24.0,
        desktopCardMaxWidth: 520.0,
        desktopTopBarHeight: 72.0,
        desktopTopBarPaddingHorizontal: 40.0,
        desktopTopBarBackgroundColor: Colors.white,
        desktopTopBarBoxShadow: BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8.0,
          offset: Offset(0, 2),
        ),
        desktopCardBorderRadius: 24.0,
        desktopCardElevation: 16.0,
        desktopCardPadding: EdgeInsets.all(48.0),
        mobileBreakpoint: 600.0,
      );
}
