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
  BrandInputConfig get inputConfig;
  BrandToggleConfig get toggleConfig;
  BrandLinkedTextConfig get linkedTextConfig;

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
  final double? horizontalPadding; // Override default padding if set
  final double?
      verticalPadding; // Override default vertical padding (and remove fixed height)
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;

  const BrandButtonConfig({
    this.borderRadius = 12.0,
    this.elevation = 0.0,
    this.shadowColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
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
  final double? horizontalPadding;
  final double? verticalPadding;

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
    this.horizontalPadding,
    this.verticalPadding,
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

enum BrandInputBorderType {
  underline,
  outline,
  none,
}

class BrandInputConfig {
  final BrandInputBorderType borderType;
  final bool filled;
  final Color? fillColor;
  final double borderRadius;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? errorFillColor;
  final double errorFontSize;
  final FontWeight errorFontWeight;
  final FontWeight? textFontWeight;
  final bool floatingLabel;
  final EdgeInsetsGeometry? labelPadding;

  const BrandInputConfig({
    this.borderType = BrandInputBorderType.outline,
    this.filled = false,
    this.fillColor,
    this.borderRadius = 4.0,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.labelColor,
    this.hintColor,
    this.contentPadding,
    this.errorFillColor,
    this.errorFontSize = 12.0,
    this.errorFontWeight = FontWeight.normal,
    this.textFontWeight,
    this.floatingLabel = true,
    this.labelPadding,
  });
}

class BrandToggleConfig {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeKnobColor;
  final Color inactiveKnobColor;
  final double trackWidth;
  final double trackHeight;
  final double knobSize;
  final double borderWidth;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;

  const BrandToggleConfig({
    required this.activeTrackColor,
    this.inactiveTrackColor = const Color(0xFFE0E0E0),
    this.activeKnobColor = const Color(0xFFFFFFFF),
    this.inactiveKnobColor = const Color(0xFFFFFFFF),
    this.trackWidth = 52.0,
    this.trackHeight = 32.0,
    this.knobSize = 28.0,
    this.borderWidth = 0.0,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });
}

class BrandLinkedTextConfig {
  final TextStyle normalTextStyle;
  final TextStyle linkTextStyle;
  final double linkUnderlineThickness;
  final double linkUnderlineOffset;

  const BrandLinkedTextConfig({
    required this.normalTextStyle,
    required this.linkTextStyle,
    this.linkUnderlineThickness = 1.0,
    this.linkUnderlineOffset = 1.0,
  });
}
