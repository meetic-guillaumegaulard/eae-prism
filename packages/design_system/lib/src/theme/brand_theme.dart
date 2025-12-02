import 'package:flutter/material.dart';
import '../brands/brand_config.dart';
import '../models/brand.dart';
import 'brand_theme_extensions.dart';

class BrandTheme {
  static ThemeData getTheme(Brand brand) {
    final config = BrandConfig.fromBrand(brand);
    final colors = config.colors;
    final buttonConfig = config.buttonConfig;
    final selectableButtonConfig = config.selectableButtonConfig;
    final checkboxConfig = config.checkboxConfig;
    final radioButtonConfig = config.radioButtonConfig;
    final inputConfig = config.inputConfig;
    final toggleConfig = config.toggleConfig;
    final linkedTextConfig = config.linkedTextConfig;
    final labeledControlConfig = config.labeledControlConfig;

    InputBorder getBorder(Color color, {double width = 1.0}) {
      switch (inputConfig.borderType) {
        case BrandInputBorderType.underline:
          return UnderlineInputBorder(
              borderSide: BorderSide(color: color, width: width));
        case BrandInputBorderType.outline:
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(inputConfig.borderRadius),
            borderSide: BorderSide(color: color, width: width),
          );
        case BrandInputBorderType.none:
          return InputBorder.none;
      }
    }

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
      ),
      extensions: [
        BrandSelectableButtonTheme(
          unselectedBorderColor: selectableButtonConfig.unselectedBorderColor,
          unselectedTextColor: selectableButtonConfig.unselectedTextColor,
          unselectedBackgroundColor:
              selectableButtonConfig.unselectedBackgroundColor,
          unselectedBorderWidth: selectableButtonConfig.unselectedBorderWidth,
          selectedBackgroundColor:
              selectableButtonConfig.selectedBackgroundColor,
          selectedForegroundColor:
              selectableButtonConfig.selectedForegroundColor,
          selectedBorderColor: selectableButtonConfig.selectedBorderColor,
          selectedBorderWidth: selectableButtonConfig.selectedBorderWidth,
          showRadioButton: selectableButtonConfig.showRadioButton,
          horizontalPadding: selectableButtonConfig.horizontalPadding,
          verticalPadding: selectableButtonConfig.verticalPadding,
        ),
        BrandCheckboxTheme(
          activeColor: checkboxConfig.activeColor,
          checkColor: checkboxConfig.checkColor,
          backgroundColor: checkboxConfig.backgroundColor,
          borderRadius: checkboxConfig.borderRadius,
          borderWidth: checkboxConfig.borderWidth,
          selectedBorderWidth: checkboxConfig.selectedBorderWidth,
          checkStrokeWidth: checkboxConfig.checkStrokeWidth,
        ),
        BrandRadioButtonTheme(
          unselectedBorderColor: radioButtonConfig.unselectedBorderColor,
          selectedBorderColor: radioButtonConfig.selectedBorderColor,
          selectedBackgroundColor: radioButtonConfig.selectedBackgroundColor,
          dotColor: radioButtonConfig.dotColor,
          borderWidth: radioButtonConfig.borderWidth,
        ),
        BrandInputTheme(
          errorFillColor: inputConfig.errorFillColor,
          labelPadding: inputConfig.labelPadding,
        ),
        BrandToggleTheme(
          activeTrackColor: toggleConfig.activeTrackColor,
          inactiveTrackColor: toggleConfig.inactiveTrackColor,
          activeKnobColor: toggleConfig.activeKnobColor,
          inactiveKnobColor: toggleConfig.inactiveKnobColor,
          trackWidth: toggleConfig.trackWidth,
          trackHeight: toggleConfig.trackHeight,
          knobSize: toggleConfig.knobSize,
          borderWidth: toggleConfig.borderWidth,
          activeBorderColor: toggleConfig.activeBorderColor,
          inactiveBorderColor: toggleConfig.inactiveBorderColor,
        ),
        BrandLinkedTextTheme(
          normalTextStyle: linkedTextConfig.normalTextStyle,
          linkTextStyle: linkedTextConfig.linkTextStyle,
          linkUnderlineThickness: linkedTextConfig.linkUnderlineThickness,
          linkUnderlineOffset: linkedTextConfig.linkUnderlineOffset,
        ),
        BrandLabeledControlTheme(
          checkboxLabelPaddingTop: labeledControlConfig.checkboxLabelPaddingTop,
          toggleLabelPaddingTop: labeledControlConfig.toggleLabelPaddingTop,
        ),
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: buttonConfig.disabledBackgroundColor,
          disabledForegroundColor: buttonConfig.disabledForegroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: buttonConfig.horizontalPadding ?? 32.0,
            vertical: buttonConfig.verticalPadding ?? 12.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonConfig.borderRadius),
          ),
          elevation: buttonConfig.elevation,
          shadowColor: buttonConfig.shadowColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displayMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: inputConfig.textFontWeight ?? FontWeight.normal,
          color: inputConfig.textColor ?? Colors.black87,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: inputConfig.filled,
        fillColor: inputConfig.fillColor,
        floatingLabelBehavior: inputConfig.floatingLabel
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.always,
        contentPadding: inputConfig.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: TextStyle(
          color: inputConfig.labelColor,
          fontWeight: FontWeight.normal,
        ),
        hintStyle: TextStyle(
          color: inputConfig.hintColor,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder:
            getBorder(inputConfig.inactiveBorderColor ?? Colors.grey),
        disabledBorder: getBorder(inputConfig.inactiveBorderColor ?? Colors.grey),
        focusedBorder: getBorder(
            inputConfig.activeBorderColor ?? colors.primary,
            width: 2.0),
        errorBorder: getBorder(inputConfig.errorBorderColor ?? Colors.red),
        focusedErrorBorder:
            getBorder(inputConfig.errorBorderColor ?? Colors.red, width: 2.0),
        errorStyle: TextStyle(
          color: inputConfig.errorBorderColor ?? Colors.red,
          fontSize: inputConfig.errorFontSize,
          fontWeight: inputConfig.errorFontWeight,
        ),
      ),
    );
  }

  static String getBrandName(Brand brand) {
    return BrandConfig.fromBrand(brand).name;
  }
}
