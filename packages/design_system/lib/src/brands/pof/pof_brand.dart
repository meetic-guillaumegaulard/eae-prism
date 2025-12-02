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
}
