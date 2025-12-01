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
  );

  @override
  BrandSelectableButtonConfig get selectableButtonConfig => const BrandSelectableButtonConfig();

  @override
  BrandCheckboxConfig get checkboxConfig => const BrandCheckboxConfig(
    activeColor: Color(0xFF0046D5), // Primary Blue border
    checkColor: Color(0xFF0046D5), // Primary Blue check
    backgroundColor: Colors.transparent, // Transparent background
    borderRadius: 6.0, // Slightly rounded
    borderWidth: 2.5, // Thicker border
  );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
    unselectedBorderColor: Color(0xFF0046D5), // Blue Outline
    selectedBorderColor: Color(0xFF0046D5), // Blue Outline
    selectedBackgroundColor: Colors.transparent, // Transparent Fill
    dotColor: Color(0xFF0046D5), // Blue Dot
    borderWidth: 3.0, // Thicker border like the image
  );
}
