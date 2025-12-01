import 'package:flutter/material.dart';
import 'brand_colors.dart';

class BrandTheme {
  static ThemeData getTheme(Brand brand) {
    final primaryColor = BrandColors.getPrimaryColor(brand);
    final secondaryColor = BrandColors.getSecondaryColor(brand);
    final backgroundColor = BrandColors.getBackgroundColor(brand);
    final surfaceColor = BrandColors.getSurfaceColor(brand);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black87,
        onSurface: Colors.black87,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
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
    switch (brand) {
      case Brand.match:
        return 'Match';
      case Brand.meetic:
        return 'Meetic';
      case Brand.okc:
        return 'OKCupid';
      case Brand.pof:
        return 'Plenty of Fish';
    }
  }
}

