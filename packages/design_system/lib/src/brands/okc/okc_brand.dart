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
  BrandSelectableButtonConfig get selectableButtonConfig => const BrandSelectableButtonConfig(
    showRadioButton: true,
    unselectedBackgroundColor: Colors.white,
    unselectedBorderColor: Color(0xFFE0E0E0), 
    unselectedTextColor: Colors.black87,
    unselectedBorderWidth: 1.0,
    selectedBorderColor: Color(0xFFE0E0E0), 
    selectedBorderWidth: 1.0, 
    selectedBackgroundColor: Colors.white, 
    selectedForegroundColor: Colors.black87, 
  );

  @override
  BrandCheckboxConfig get checkboxConfig => const BrandCheckboxConfig(
    activeColor: Color(0xFF0046D5), 
    checkColor: Color(0xFF0046D5), 
    backgroundColor: Colors.transparent, 
    borderRadius: 6.0, 
    borderWidth: 2.5, 
    checkStrokeWidth: 2.5, // Slightly thicker
  );

  @override
  BrandRadioButtonConfig get radioButtonConfig => const BrandRadioButtonConfig(
    unselectedBorderColor: Color(0xFF0046D5), 
    selectedBorderColor: Color(0xFF0046D5), 
    selectedBackgroundColor: Colors.transparent, 
    dotColor: Color(0xFF0046D5), 
    borderWidth: 2.0, 
  );
}
