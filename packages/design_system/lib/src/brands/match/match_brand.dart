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
        borderRadius: 4.0,
      );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
        unselectedBorderColor: Color(0xFFC5C7D8),
        selectedBorderColor: Color(0xFF11144C),
        selectedBackgroundColor: Color(0xFF11144C), // Filled
        dotColor: Colors.white, // White dot
      );
}
