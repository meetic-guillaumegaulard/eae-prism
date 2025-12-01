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
}
