import 'dart:ui';
import 'package:flutter/material.dart';

class BrandSelectableButtonTheme
    extends ThemeExtension<BrandSelectableButtonTheme> {
  final Color? unselectedBorderColor;
  final Color? unselectedTextColor;
  final Color? unselectedBackgroundColor;
  final double unselectedBorderWidth;

  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBorderColor;
  final double selectedBorderWidth;

  final bool showRadioButton;

  const BrandSelectableButtonTheme({
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

  @override
  ThemeExtension<BrandSelectableButtonTheme> copyWith({
    Color? unselectedBorderColor,
    Color? unselectedTextColor,
    Color? unselectedBackgroundColor,
    double? unselectedBorderWidth,
    Color? selectedBackgroundColor,
    Color? selectedForegroundColor,
    Color? selectedBorderColor,
    double? selectedBorderWidth,
    bool? showRadioButton,
  }) {
    return BrandSelectableButtonTheme(
      unselectedBorderColor:
          unselectedBorderColor ?? this.unselectedBorderColor,
      unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
      unselectedBackgroundColor:
          unselectedBackgroundColor ?? this.unselectedBackgroundColor,
      unselectedBorderWidth:
          unselectedBorderWidth ?? this.unselectedBorderWidth,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedForegroundColor:
          selectedForegroundColor ?? this.selectedForegroundColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      showRadioButton: showRadioButton ?? this.showRadioButton,
    );
  }

  @override
  ThemeExtension<BrandSelectableButtonTheme> lerp(
    ThemeExtension<BrandSelectableButtonTheme>? other,
    double t,
  ) {
    if (other is! BrandSelectableButtonTheme) {
      return this;
    }
    return BrandSelectableButtonTheme(
      unselectedBorderColor:
          Color.lerp(unselectedBorderColor, other.unselectedBorderColor, t),
      unselectedTextColor:
          Color.lerp(unselectedTextColor, other.unselectedTextColor, t),
      unselectedBackgroundColor: Color.lerp(
          unselectedBackgroundColor, other.unselectedBackgroundColor, t),
      unselectedBorderWidth:
          lerpDouble(unselectedBorderWidth, other.unselectedBorderWidth, t)!,
      selectedBackgroundColor:
          Color.lerp(selectedBackgroundColor, other.selectedBackgroundColor, t),
      selectedForegroundColor:
          Color.lerp(selectedForegroundColor, other.selectedForegroundColor, t),
      selectedBorderColor:
          Color.lerp(selectedBorderColor, other.selectedBorderColor, t),
      selectedBorderWidth:
          lerpDouble(selectedBorderWidth, other.selectedBorderWidth, t)!,
      showRadioButton: t < 0.5 ? showRadioButton : other.showRadioButton,
    );
  }
}

class BrandCheckboxTheme extends ThemeExtension<BrandCheckboxTheme> {
  final Color? activeColor;
  final Color? checkColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final double selectedBorderWidth;
  final double checkStrokeWidth;

  const BrandCheckboxTheme({
    this.activeColor,
    this.checkColor,
    this.backgroundColor,
    this.borderRadius = 4.0,
    this.borderWidth = 2.0,
    this.selectedBorderWidth = 2.0,
    this.checkStrokeWidth = 2.0,
  });

  @override
  ThemeExtension<BrandCheckboxTheme> copyWith({
    Color? activeColor,
    Color? checkColor,
    Color? backgroundColor,
    double? borderRadius,
    double? borderWidth,
    double? selectedBorderWidth,
    double? checkStrokeWidth,
  }) {
    return BrandCheckboxTheme(
      activeColor: activeColor ?? this.activeColor,
      checkColor: checkColor ?? this.checkColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      checkStrokeWidth: checkStrokeWidth ?? this.checkStrokeWidth,
    );
  }

  @override
  ThemeExtension<BrandCheckboxTheme> lerp(
    ThemeExtension<BrandCheckboxTheme>? other,
    double t,
  ) {
    if (other is! BrandCheckboxTheme) {
      return this;
    }
    return BrandCheckboxTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      checkColor: Color.lerp(checkColor, other.checkColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      selectedBorderWidth:
          lerpDouble(selectedBorderWidth, other.selectedBorderWidth, t)!,
      checkStrokeWidth:
          lerpDouble(checkStrokeWidth, other.checkStrokeWidth, t)!,
    );
  }
}

class BrandRadioButtonTheme extends ThemeExtension<BrandRadioButtonTheme> {
  final Color? unselectedBorderColor;
  final Color? selectedBorderColor;
  final Color? selectedBackgroundColor;
  final Color? dotColor;
  final double borderWidth;

  const BrandRadioButtonTheme({
    this.unselectedBorderColor,
    this.selectedBorderColor,
    this.selectedBackgroundColor,
    this.dotColor,
    this.borderWidth = 2.0,
  });

  @override
  ThemeExtension<BrandRadioButtonTheme> copyWith({
    Color? unselectedBorderColor,
    Color? selectedBorderColor,
    Color? selectedBackgroundColor,
    Color? dotColor,
    double? borderWidth,
  }) {
    return BrandRadioButtonTheme(
      unselectedBorderColor:
          unselectedBorderColor ?? this.unselectedBorderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      dotColor: dotColor ?? this.dotColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  @override
  ThemeExtension<BrandRadioButtonTheme> lerp(
    ThemeExtension<BrandRadioButtonTheme>? other,
    double t,
  ) {
    if (other is! BrandRadioButtonTheme) {
      return this;
    }
    return BrandRadioButtonTheme(
      unselectedBorderColor:
          Color.lerp(unselectedBorderColor, other.unselectedBorderColor, t),
      selectedBorderColor:
          Color.lerp(selectedBorderColor, other.selectedBorderColor, t),
      selectedBackgroundColor:
          Color.lerp(selectedBackgroundColor, other.selectedBackgroundColor, t),
      dotColor: Color.lerp(dotColor, other.dotColor, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
    );
  }
}
