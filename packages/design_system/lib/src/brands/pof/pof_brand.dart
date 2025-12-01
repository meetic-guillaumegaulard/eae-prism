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
        borderRadius: 4.0,
        borderWidth: 2.0,
      );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
        unselectedBorderColor: Colors.black,
        selectedBorderColor: Colors.black,
        selectedBackgroundColor: Color(0xFFFF9E80), // Salmon Fill
        dotColor: Colors.black, // Black Dot
        borderWidth: 2.0, // Thick border
      );
}
