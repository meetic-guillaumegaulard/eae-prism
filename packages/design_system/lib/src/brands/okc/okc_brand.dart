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
}
