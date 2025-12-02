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
      labelPadding:
          EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t),
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
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t),
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
      linkUnderlineThickness:
          lerpDouble(linkUnderlineThickness, other.linkUnderlineThickness, t),
      linkUnderlineOffset:
          lerpDouble(linkUnderlineOffset, other.linkUnderlineOffset, t),
    );
  }
}

class BrandLabeledControlTheme
    extends ThemeExtension<BrandLabeledControlTheme> {
  final double? checkboxLabelPaddingTop;
  final double? toggleLabelPaddingTop;

  const BrandLabeledControlTheme({
    this.checkboxLabelPaddingTop,
    this.toggleLabelPaddingTop,
  });

  @override
  ThemeExtension<BrandLabeledControlTheme> copyWith({
    double? checkboxLabelPaddingTop,
    double? toggleLabelPaddingTop,
  }) {
    return BrandLabeledControlTheme(
      checkboxLabelPaddingTop:
          checkboxLabelPaddingTop ?? this.checkboxLabelPaddingTop,
      toggleLabelPaddingTop:
          toggleLabelPaddingTop ?? this.toggleLabelPaddingTop,
    );
  }

  @override
  ThemeExtension<BrandLabeledControlTheme> lerp(
    ThemeExtension<BrandLabeledControlTheme>? other,
    double t,
  ) {
    if (other is! BrandLabeledControlTheme) {
      return this;
    }
    return BrandLabeledControlTheme(
      checkboxLabelPaddingTop:
          lerpDouble(checkboxLabelPaddingTop, other.checkboxLabelPaddingTop, t),
      toggleLabelPaddingTop:
          lerpDouble(toggleLabelPaddingTop, other.toggleLabelPaddingTop, t),
    );
  }
}

class BrandSliderTheme extends ThemeExtension<BrandSliderTheme> {
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final Color? overlayColor;
  final double trackHeight;
  final double thumbRadius;
  final double overlayRadius;
  final double thumbElevation;
  final Color? thumbShadowColor;
  final double thumbBorderWidth;
  final Color? thumbBorderColor;

  const BrandSliderTheme({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.overlayColor,
    this.trackHeight = 4.0,
    this.thumbRadius = 10.0,
    this.overlayRadius = 20.0,
    this.thumbElevation = 0.0,
    this.thumbShadowColor,
    this.thumbBorderWidth = 0.0,
    this.thumbBorderColor,
  });

  @override
  ThemeExtension<BrandSliderTheme> copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
    Color? overlayColor,
    double? trackHeight,
    double? thumbRadius,
    double? overlayRadius,
    double? thumbElevation,
    Color? thumbShadowColor,
    double? thumbBorderWidth,
    Color? thumbBorderColor,
  }) {
    return BrandSliderTheme(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      overlayColor: overlayColor ?? this.overlayColor,
      trackHeight: trackHeight ?? this.trackHeight,
      thumbRadius: thumbRadius ?? this.thumbRadius,
      overlayRadius: overlayRadius ?? this.overlayRadius,
      thumbElevation: thumbElevation ?? this.thumbElevation,
      thumbShadowColor: thumbShadowColor ?? this.thumbShadowColor,
      thumbBorderWidth: thumbBorderWidth ?? this.thumbBorderWidth,
      thumbBorderColor: thumbBorderColor ?? this.thumbBorderColor,
    );
  }

  @override
  ThemeExtension<BrandSliderTheme> lerp(
    ThemeExtension<BrandSliderTheme>? other,
    double t,
  ) {
    if (other is! BrandSliderTheme) {
      return this;
    }
    return BrandSliderTheme(
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t),
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t),
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t),
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t),
      trackHeight: lerpDouble(trackHeight, other.trackHeight, t)!,
      thumbRadius: lerpDouble(thumbRadius, other.thumbRadius, t)!,
      overlayRadius: lerpDouble(overlayRadius, other.overlayRadius, t)!,
      thumbElevation: lerpDouble(thumbElevation, other.thumbElevation, t)!,
      thumbShadowColor: Color.lerp(thumbShadowColor, other.thumbShadowColor, t),
      thumbBorderWidth:
          lerpDouble(thumbBorderWidth, other.thumbBorderWidth, t)!,
      thumbBorderColor: Color.lerp(thumbBorderColor, other.thumbBorderColor, t),
    );
  }
}

class BrandSelectionGroupTheme
    extends ThemeExtension<BrandSelectionGroupTheme> {
  final bool showDividers;
  final Color? dividerColor;
  final double dividerThickness;
  final double dividerIndent;
  final bool showCard;
  final Color? cardBackgroundColor;

  const BrandSelectionGroupTheme({
    this.showDividers = false,
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.dividerIndent = 0.0,
    this.showCard = false,
    this.cardBackgroundColor,
  });

  @override
  ThemeExtension<BrandSelectionGroupTheme> copyWith({
    bool? showDividers,
    Color? dividerColor,
    double? dividerThickness,
    double? dividerIndent,
    bool? showCard,
    Color? cardBackgroundColor,
  }) {
    return BrandSelectionGroupTheme(
      showDividers: showDividers ?? this.showDividers,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      dividerIndent: dividerIndent ?? this.dividerIndent,
      showCard: showCard ?? this.showCard,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
    );
  }

  @override
  ThemeExtension<BrandSelectionGroupTheme> lerp(
    ThemeExtension<BrandSelectionGroupTheme>? other,
    double t,
  ) {
    if (other is! BrandSelectionGroupTheme) {
      return this;
    }
    return BrandSelectionGroupTheme(
      showDividers: t < 0.5 ? showDividers : other.showDividers,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      dividerThickness:
          lerpDouble(dividerThickness, other.dividerThickness, t)!,
      dividerIndent: lerpDouble(dividerIndent, other.dividerIndent, t)!,
      showCard: t < 0.5 ? showCard : other.showCard,
      cardBackgroundColor:
          Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t),
    );
  }
}

class BrandTagTheme extends ThemeExtension<BrandTagTheme> {
  // Couleurs pour le mode lecture seule
  final Color? readOnlyBackgroundColor;
  final Color? readOnlyForegroundColor;
  final Color? readOnlyBorderColor;

  // Couleurs pour le mode sélectionnable - état non sélectionné
  final Color? unselectedBackgroundColor;
  final Color? unselectedForegroundColor;
  final Color? unselectedBorderColor;

  // Couleurs pour le mode sélectionnable - état sélectionné
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBorderColor;

  // Hauteur fixe pour les tags sélectionnables
  final double? selectableHeight;

  const BrandTagTheme({
    this.readOnlyBackgroundColor,
    this.readOnlyForegroundColor,
    this.readOnlyBorderColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.unselectedBorderColor,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedBorderColor,
    this.selectableHeight,
  });

  @override
  ThemeExtension<BrandTagTheme> copyWith({
    Color? readOnlyBackgroundColor,
    Color? readOnlyForegroundColor,
    Color? readOnlyBorderColor,
    Color? unselectedBackgroundColor,
    Color? unselectedForegroundColor,
    Color? unselectedBorderColor,
    Color? selectedBackgroundColor,
    Color? selectedForegroundColor,
    Color? selectedBorderColor,
    double? selectableHeight,
  }) {
    return BrandTagTheme(
      readOnlyBackgroundColor:
          readOnlyBackgroundColor ?? this.readOnlyBackgroundColor,
      readOnlyForegroundColor:
          readOnlyForegroundColor ?? this.readOnlyForegroundColor,
      readOnlyBorderColor: readOnlyBorderColor ?? this.readOnlyBorderColor,
      unselectedBackgroundColor:
          unselectedBackgroundColor ?? this.unselectedBackgroundColor,
      unselectedForegroundColor:
          unselectedForegroundColor ?? this.unselectedForegroundColor,
      unselectedBorderColor:
          unselectedBorderColor ?? this.unselectedBorderColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      selectedForegroundColor:
          selectedForegroundColor ?? this.selectedForegroundColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      selectableHeight: selectableHeight ?? this.selectableHeight,
    );
  }

  @override
  ThemeExtension<BrandTagTheme> lerp(
    ThemeExtension<BrandTagTheme>? other,
    double t,
  ) {
    if (other is! BrandTagTheme) {
      return this;
    }
    return BrandTagTheme(
      readOnlyBackgroundColor:
          Color.lerp(readOnlyBackgroundColor, other.readOnlyBackgroundColor, t),
      readOnlyForegroundColor:
          Color.lerp(readOnlyForegroundColor, other.readOnlyForegroundColor, t),
      readOnlyBorderColor:
          Color.lerp(readOnlyBorderColor, other.readOnlyBorderColor, t),
      unselectedBackgroundColor: Color.lerp(
          unselectedBackgroundColor, other.unselectedBackgroundColor, t),
      unselectedForegroundColor: Color.lerp(
          unselectedForegroundColor, other.unselectedForegroundColor, t),
      unselectedBorderColor:
          Color.lerp(unselectedBorderColor, other.unselectedBorderColor, t),
      selectedBackgroundColor:
          Color.lerp(selectedBackgroundColor, other.selectedBackgroundColor, t),
      selectedForegroundColor:
          Color.lerp(selectedForegroundColor, other.selectedForegroundColor, t),
      selectedBorderColor:
          Color.lerp(selectedBorderColor, other.selectedBorderColor, t),
      selectableHeight: lerpDouble(selectableHeight, other.selectableHeight, t),
    );
  }
}

class BrandProgressBarTheme extends ThemeExtension<BrandProgressBarTheme> {
  final Color? activeColor;
  final Gradient? activeGradient;
  final Color? inactiveColor;
  final Color? counterTextColor;
  final double height;
  final double borderRadius;

  const BrandProgressBarTheme({
    this.activeColor,
    this.activeGradient,
    this.inactiveColor,
    this.counterTextColor,
    this.height = 8.0,
    this.borderRadius = 4.0,
  });

  @override
  ThemeExtension<BrandProgressBarTheme> copyWith({
    Color? activeColor,
    Gradient? activeGradient,
    Color? inactiveColor,
    Color? counterTextColor,
    double? height,
    double? borderRadius,
  }) {
    return BrandProgressBarTheme(
      activeColor: activeColor ?? this.activeColor,
      activeGradient: activeGradient ?? this.activeGradient,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      counterTextColor: counterTextColor ?? this.counterTextColor,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<BrandProgressBarTheme> lerp(
    ThemeExtension<BrandProgressBarTheme>? other,
    double t,
  ) {
    if (other is! BrandProgressBarTheme) {
      return this;
    }
    return BrandProgressBarTheme(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      activeGradient: Gradient.lerp(activeGradient, other.activeGradient, t),
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t),
      counterTextColor: Color.lerp(counterTextColor, other.counterTextColor, t),
      height: lerpDouble(height, other.height, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
    );
  }
}
