import 'package:flutter/material.dart';
import 'match/match_brand.dart';
import 'meetic/meetic_brand.dart';
import 'okc/okc_brand.dart';
import 'pof/pof_brand.dart';
import '../models/brand.dart';

abstract class BrandConfig {
  String get name;
  BrandColorsConfig get colors;
  BrandButtonConfig get buttonConfig;
  BrandSelectableButtonConfig get selectableButtonConfig;
  BrandCheckboxConfig get checkboxConfig;
  BrandRadioButtonConfig get radioButtonConfig;

  static BrandConfig fromBrand(Brand brand) {
    switch (brand) {
      case Brand.match:
        return MatchBrand();
      case Brand.meetic:
        return MeeticBrand();
      case Brand.okc:
        return OkcBrand();
      case Brand.pof:
        return PofBrand();
    }
  }
}

class BrandColorsConfig {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;

  const BrandColorsConfig({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
  });
}

class BrandButtonConfig {
  final double borderRadius;
  final double elevation;
  final Color? shadowColor;

  const BrandButtonConfig({
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
  });
}

class BrandSelectableButtonConfig {
  // Unselected State
  final Color? unselectedBorderColor;
  final Color? unselectedTextColor;
  final Color? unselectedBackgroundColor;
  final double unselectedBorderWidth;

  // Selected State
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBorderColor;
  final double selectedBorderWidth;
  final bool showRadioButton;

  const BrandSelectableButtonConfig({
    this.unselectedBorderColor,
    this.unselectedTextColor,
    this.unselectedBackgroundColor,
    this.unselectedBorderWidth = 1.0,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedBorderColor,
    this.selectedBorderWidth = 0.0,
    this.showRadioButton = false,
  });
}

class BrandCheckboxConfig {
  final Color activeColor;
  final Color? checkColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double borderWidth; // Unselected border width
  final double
      selectedBorderWidth; // Selected border width (defaults to borderWidth if null)
  final double checkStrokeWidth;

  const BrandCheckboxConfig({
    required this.activeColor,
    this.checkColor,
    this.backgroundColor,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    double? selectedBorderWidth,
    this.checkStrokeWidth = 2.0,
  }) : selectedBorderWidth = selectedBorderWidth ?? borderWidth;
}

class BrandRadioButtonConfig {
  final Color unselectedBorderColor;
  final Color selectedBorderColor;
  final Color
      selectedBackgroundColor; // Background of the outer circle when selected
  final Color dotColor; // Color of the inner dot
  final double borderWidth;

  const BrandRadioButtonConfig({
    required this.unselectedBorderColor,
    required this.selectedBorderColor,
    required this.selectedBackgroundColor,
    required this.dotColor,
    this.borderWidth = 2.0,
  });
}
