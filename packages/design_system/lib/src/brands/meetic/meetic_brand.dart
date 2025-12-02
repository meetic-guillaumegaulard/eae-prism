import 'package:flutter/material.dart';
import '../brand_config.dart';

class MeeticBrand implements BrandConfig {
  @override
  String get name => 'Meetic';

  @override
  BrandColorsConfig get colors => const BrandColorsConfig(
        primary: Color(0xFFE9006D),
        secondary: Color(0xFFFF4D9A),
        background: Color(0xFFFFFFFF),
        surface: Color(0xFFF5F4F9),
      );

  @override
  BrandButtonConfig get buttonConfig => const BrandButtonConfig(
        borderRadius: 999.0, // Capsule shape
        horizontalPadding: 48.0, // Wide padding
        disabledBackgroundColor: Color(0xFFF2C4D9), // Light pink for disabled
        disabledForegroundColor: Colors.white, // White text
      );

  @override
  BrandSelectableButtonConfig get selectableButtonConfig =>
      const BrandSelectableButtonConfig(
        unselectedBorderColor:
            Color(0xFFC5C0D0), // Pale purple-grey border for unselected state
        unselectedTextColor: Color(0xFF2B0A3D), // Dark purple text
        unselectedBackgroundColor: Colors.transparent,
      );

  @override
  BrandCheckboxConfig get checkboxConfig => const BrandCheckboxConfig(
        activeColor: Color(0xFFE9006D),
        checkColor: Colors.white,
        backgroundColor: Color(0xFFE9006D),
        borderRadius: 8.0,
        checkStrokeWidth: 2.0, // Standard
      );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
        unselectedBorderColor: Color(0xFFC5C0D0),
        selectedBorderColor: Color(0xFFE9006D),
        selectedBackgroundColor: Color(0xFFE9006D), // Filled
        dotColor: Colors.white, // White dot
      );

  @override
  BrandInputConfig get inputConfig => const BrandInputConfig(
        borderType: BrandInputBorderType.underline,
        filled: false,
        activeBorderColor: Color(0xFFE9006D), // Primary color for focus
        inactiveBorderColor: Color(0xFFC5C0D0),
        errorBorderColor: Color(0xFFD6002F), // Standard error red
        textColor: Color(0xFF2B0A3D), // Dark purple text
        textFontWeight: FontWeight.w600,
        labelColor: Color(0xFFC5C0D0),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        errorFillColor: Color(0xFFFCE8E6), // Light red background on error
        errorFontSize: 12.0,
        errorFontWeight: FontWeight.bold,
      );

  @override
  BrandToggleConfig get toggleConfig => const BrandToggleConfig(
        activeTrackColor: Color(0xFFE9006D),
        inactiveTrackColor: Color(0xFFC5C0D0),
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
          color: Color(0xFF2B0A3D),
          fontWeight: FontWeight.normal,
        ),
        linkTextStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF0000FF), // Bleu pour les liens
          fontWeight: FontWeight.normal,
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
        activeTrackColor: Color(0xFFE9006D), // Rose Meetic
        inactiveTrackColor: Color(0xFFE0E0E0), // Gris clair
        thumbColor: Colors.white, // Curseurs blancs
        overlayColor: Color(0x1FE9006D), // Rose très transparent pour l'effet
        trackHeight: 6.0,
        thumbRadius: 16.0,
        overlayRadius: 24.0,
        thumbElevation: 4.0, // Ombre sur les curseurs
        thumbShadowColor: Color(0x40000000), // Ombre grise semi-transparente
      );

  @override
  BrandTypographyConfig get typographyConfig => const BrandTypographyConfig(
        headlineFontFamily: 'Lora', // Police serif élégante comme Match
        titleFontFamily: 'Lora',
        headlineFontWeight: FontWeight.w600, // Semi-bold
        titleFontWeight: FontWeight.w600,
        headlineColor: Color(0xFF2B0A3D), // Violet foncé Meetic
        titleColor: Color(0xFF2B0A3D),
      );
}
