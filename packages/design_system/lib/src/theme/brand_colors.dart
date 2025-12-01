import 'package:flutter/material.dart';

enum Brand {
  match,
  meetic,
  okc,
  pof,
}

class BrandColors {
  // Match colors - Red/Pink theme
  static const matchPrimary = Color(0xFFD6002F);
  static const matchSecondary = Color(0xFFFF6B6B);
  static const matchBackground = Color(0xFFFFFFFF);
  static const matchSurface = Color(0xFFF8F8F8);

  // Meetic colors - Purple theme
  static const meeticPrimary = Color(0xFF6C5CE7);
  static const meeticSecondary = Color(0xFFA29BFE);
  static const meeticBackground = Color(0xFFFFFFFF);
  static const meeticSurface = Color(0xFFF5F4F9);

  // OKCupid colors - Blue/Teal theme
  static const okcPrimary = Color(0xFF00A8E8);
  static const okcSecondary = Color(0xFF00D9FF);
  static const okcBackground = Color(0xFFFFFFFF);
  static const okcSurface = Color(0xFFF0F9FF);

  // Plenty of Fish colors - Orange/Green theme
  static const pofPrimary = Color(0xFFFF6B35);
  static const pofSecondary = Color(0xFF4ECDC4);
  static const pofBackground = Color(0xFFFFFFFF);
  static const pofSurface = Color(0xFFFFF5F0);

  static Color getPrimaryColor(Brand brand) {
    switch (brand) {
      case Brand.match:
        return matchPrimary;
      case Brand.meetic:
        return meeticPrimary;
      case Brand.okc:
        return okcPrimary;
      case Brand.pof:
        return pofPrimary;
    }
  }

  static Color getSecondaryColor(Brand brand) {
    switch (brand) {
      case Brand.match:
        return matchSecondary;
      case Brand.meetic:
        return meeticSecondary;
      case Brand.okc:
        return okcSecondary;
      case Brand.pof:
        return pofSecondary;
    }
  }

  static Color getBackgroundColor(Brand brand) {
    switch (brand) {
      case Brand.match:
        return matchBackground;
      case Brand.meetic:
        return meeticBackground;
      case Brand.okc:
        return okcBackground;
      case Brand.pof:
        return pofBackground;
    }
  }

  static Color getSurfaceColor(Brand brand) {
    switch (brand) {
      case Brand.match:
        return matchSurface;
      case Brand.meetic:
        return meeticSurface;
      case Brand.okc:
        return okcSurface;
      case Brand.pof:
        return pofSurface;
    }
  }
}

