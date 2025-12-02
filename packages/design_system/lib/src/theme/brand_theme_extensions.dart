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
  final double? horizontalPadding;
  final double? verticalPadding;

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
    this.horizontalPadding,
    this.verticalPadding,
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
    double? horizontalPadding,
    double? verticalPadding,
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
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      verticalPadding: verticalPadding ?? this.verticalPadding,
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
      horizontalPadding:
          lerpDouble(horizontalPadding, other.horizontalPadding, t),
      verticalPadding: lerpDouble(verticalPadding, other.verticalPadding, t),
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

class BrandInputTheme extends ThemeExtension<BrandInputTheme> {
  final Color? errorFillColor;
  final EdgeInsetsGeometry? labelPadding;

  const BrandInputTheme({
    this.errorFillColor,
    this.labelPadding,
  });

  @override
  ThemeExtension<BrandInputTheme> copyWith({
    Color? errorFillColor,
    EdgeInsetsGeometry? labelPadding,
  }) {
    return BrandInputTheme(
      errorFillColor: errorFillColor ?? this.errorFillColor,
      labelPadding: labelPadding ?? this.labelPadding,
    );
  }

  @override
  ThemeExtension<BrandInputTheme> lerp(
    ThemeExtension<BrandInputTheme>? other,
    double t,
  ) {
    if (other is! BrandInputTheme) {
      return this;
    }
    return BrandInputTheme(
      errorFillColor: Color.lerp(errorFillColor, other.errorFillColor, t),
      labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t),
    );
  }
}

class BrandToggleTheme extends ThemeExtension<BrandToggleTheme> {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeKnobColor;
  final Color? inactiveKnobColor;
  final double trackWidth;
  final double trackHeight;
  final double knobSize;
  final double borderWidth;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;

  const BrandToggleTheme({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeKnobColor,
    this.inactiveKnobColor,
    this.trackWidth = 52.0,
    this.trackHeight = 32.0,
    this.knobSize = 28.0,
    this.borderWidth = 0.0,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });

  @override
  ThemeExtension<BrandToggleTheme> copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? activeKnobColor,
    Color? inactiveKnobColor,
    double? trackWidth,
    double? trackHeight,
    double? knobSize,
    double? borderWidth,
    Color? activeBorderColor,
    Color? inactiveBorderColor,
  }) {
    return BrandToggleTheme(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      activeKnobColor: activeKnobColor ?? this.activeKnobColor,
      inactiveKnobColor: inactiveKnobColor ?? this.inactiveKnobColor,
      trackWidth: trackWidth ?? this.trackWidth,
      trackHeight: trackHeight ?? this.trackHeight,
      knobSize: knobSize ?? this.knobSize,
      borderWidth: borderWidth ?? this.borderWidth,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
    );
  }

  @override
  ThemeExtension<BrandToggleTheme> lerp(
    ThemeExtension<BrandToggleTheme>? other,
    double t,
  ) {
    if (other is! BrandToggleTheme) {
      return this;
    }
    return BrandToggleTheme(
      activeTrackColor:
          Color.lerp(activeTrackColor, other.activeTrackColor, t),
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t),
      activeKnobColor: Color.lerp(activeKnobColor, other.activeKnobColor, t),
      inactiveKnobColor:
          Color.lerp(inactiveKnobColor, other.inactiveKnobColor, t),
      trackWidth: lerpDouble(trackWidth, other.trackWidth, t)!,
      trackHeight: lerpDouble(trackHeight, other.trackHeight, t)!,
      knobSize: lerpDouble(knobSize, other.knobSize, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      activeBorderColor:
          Color.lerp(activeBorderColor, other.activeBorderColor, t),
      inactiveBorderColor:
          Color.lerp(inactiveBorderColor, other.inactiveBorderColor, t),
    );
  }
}

class BrandLinkedTextTheme extends ThemeExtension<BrandLinkedTextTheme> {
  final TextStyle? normalTextStyle;
  final TextStyle? linkTextStyle;
  final double? linkUnderlineThickness;
  final double? linkUnderlineOffset;

  const BrandLinkedTextTheme({
    this.normalTextStyle,
    this.linkTextStyle,
    this.linkUnderlineThickness,
    this.linkUnderlineOffset,
  });

  @override
  ThemeExtension<BrandLinkedTextTheme> copyWith({
    TextStyle? normalTextStyle,
    TextStyle? linkTextStyle,
    double? linkUnderlineThickness,
    double? linkUnderlineOffset,
  }) {
    return BrandLinkedTextTheme(
      normalTextStyle: normalTextStyle ?? this.normalTextStyle,
      linkTextStyle: linkTextStyle ?? this.linkTextStyle,
      linkUnderlineThickness:
          linkUnderlineThickness ?? this.linkUnderlineThickness,
      linkUnderlineOffset: linkUnderlineOffset ?? this.linkUnderlineOffset,
    );
  }

  @override
  ThemeExtension<BrandLinkedTextTheme> lerp(
    ThemeExtension<BrandLinkedTextTheme>? other,
    double t,
  ) {
    if (other is! BrandLinkedTextTheme) {
      return this;
    }
    return BrandLinkedTextTheme(
      normalTextStyle:
          TextStyle.lerp(normalTextStyle, other.normalTextStyle, t),
      linkTextStyle: TextStyle.lerp(linkTextStyle, other.linkTextStyle, t),
      linkUnderlineThickness: lerpDouble(
          linkUnderlineThickness, other.linkUnderlineThickness, t),
      linkUnderlineOffset:
          lerpDouble(linkUnderlineOffset, other.linkUnderlineOffset, t),
    );
  }
}
