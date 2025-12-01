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
          unselectedBackgroundColor: selectableButtonConfig.unselectedBackgroundColor,
          unselectedBorderWidth: selectableButtonConfig.unselectedBorderWidth,
          selectedBackgroundColor: selectableButtonConfig.selectedBackgroundColor,
          selectedForegroundColor: selectableButtonConfig.selectedForegroundColor,
          selectedBorderColor: selectableButtonConfig.selectedBorderColor,
          selectedBorderWidth: selectableButtonConfig.selectedBorderWidth,
          showRadioButton: selectableButtonConfig.showRadioButton,
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
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  static String getBrandName(Brand brand) {
    return BrandConfig.fromBrand(brand).name;
  }
}
