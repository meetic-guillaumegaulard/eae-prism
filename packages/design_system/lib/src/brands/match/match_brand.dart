import 'package:flutter/material.dart';
import '../brand_config.dart';

class MatchBrand implements BrandConfig {
  @override
  String get name => 'Match';

  @override
  BrandColorsConfig get colors => const BrandColorsConfig(
        primary: Color(0xFF11144C),
        secondary: Color(0xFF2A2D7C),
        background: Color(0xFFFFFFFF),
        surface: Color(0xFFF8F8F8),
      );

  @override
  BrandButtonConfig get buttonConfig => const BrandButtonConfig(
        borderRadius: 999.0, // Capsule shape
        horizontalPadding: 48.0, // Wide padding
        disabledBackgroundColor:
            Color(0xFFD1D1D6), // Grey background for disabled
        disabledForegroundColor: Colors.white, // White text for disabled
      );

  @override
  BrandSelectableButtonConfig get selectableButtonConfig =>
      const BrandSelectableButtonConfig(
        unselectedBorderColor: Color(0xFFC5C7D8), // Light grey-blue border
        unselectedTextColor: Color(0xFF11144C), // Primary color for text
        unselectedBackgroundColor: Colors.transparent,
      );

  @override
  BrandCheckboxConfig get checkboxConfig => const BrandCheckboxConfig(
        activeColor: Color(0xFF11144C),
        checkColor: Colors.white,
        backgroundColor: Color(0xFF11144C),
        borderRadius: 8.0,
        checkStrokeWidth: 2.0, // Standard
      );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
        unselectedBorderColor: Color(0xFFC5C7D8),
        selectedBorderColor: Color(0xFF11144C),
        selectedBackgroundColor: Color(0xFF11144C), // Filled
        dotColor: Colors.white, // White dot
      );

  @override
  BrandInputConfig get inputConfig => const BrandInputConfig(
        borderType: BrandInputBorderType.underline,
        filled: false,
        activeBorderColor: Color(0xFF3850C4), // New blue color for focus
        inactiveBorderColor: Color(0xFFC5C7D8),
        errorBorderColor: Color(0xFFD6002F), // Match red for error
        textColor: Color(0xFF11144C),
        textFontWeight: FontWeight.w600,
        labelColor: Color(0xFFC5C7D8),
        contentPadding:
            EdgeInsets.symmetric(vertical: 0.0), // Reduced from 12.0
        errorFillColor: Color(0xFFFCE8E6), // Light red background on error
        errorFontSize: 12.0, // Reset to standard size
        errorFontWeight: FontWeight.bold, // Thicker font weight for errors
      );

  @override
  BrandToggleConfig get toggleConfig => const BrandToggleConfig(
        activeTrackColor: Color(0xFF11144C),
        inactiveTrackColor: Color(0xFFC5C7D8),
        activeKnobColor: Colors.white,
        inactiveKnobColor: Colors.white,
        trackWidth: 40.0,
        trackHeight: 24.0,
        knobSize: 20.0,
      );

  @override
  BrandLinkedTextConfig get linkedTextConfig => const BrandLinkedTextConfig(
        normalTextStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF11144C),
          fontWeight: FontWeight.normal,
        ),
        linkTextStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF3850C4),
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
        activeTrackColor: Color(0xFF11144C), // Bleu Match
        inactiveTrackColor: Color(0xFFE0E0E0), // Gris clair
        thumbColor: Colors.white, // Curseurs blancs
        overlayColor: Color(0x1F11144C), // Bleu très transparent pour l'effet
        trackHeight: 6.0,
        thumbRadius: 16.0,
        overlayRadius: 24.0,
        thumbElevation: 4.0, // Ombre sur les curseurs
        thumbShadowColor: Color(0x40000000), // Ombre grise semi-transparente
      );

  @override
  BrandTypographyConfig get typographyConfig => const BrandTypographyConfig(
        headlineFontFamily:
            'Lora', // Police serif élégante pour les grands titres
        titleFontFamily: 'Lora', // Également pour les titres moyens
        headlineFontWeight: FontWeight.w600, // Semi-bold pour les grands titres
        titleFontWeight: FontWeight.w600, // Semi-bold pour les sous-titres
        headlineColor: Color(0xFF11144C), // Bleu foncé Match pour les titres
        titleColor: Color(0xFF11144C), // Bleu foncé Match pour les sous-titres
      );
}
