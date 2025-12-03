import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final sliderConfig = config.sliderConfig;
    final typographyConfig = config.typographyConfig;
    final selectionGroupConfig = config.selectionGroupConfig;
    final tagConfig = config.tagConfig;
    final progressBarConfig = config.progressBarConfig;
    final screenLayoutConfig = config.screenLayoutConfig;
    final landingScreenConfig = config.landingScreenConfig;
    final logoConfig = config.logoConfig;

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
        BrandButtonTheme(
          outlineElevation: buttonConfig.outlineElevation,
        ),
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
        BrandSliderTheme(
          activeTrackColor: sliderConfig.activeTrackColor,
          inactiveTrackColor: sliderConfig.inactiveTrackColor,
          thumbColor: sliderConfig.thumbColor,
          overlayColor: sliderConfig.overlayColor,
          trackHeight: sliderConfig.trackHeight,
          thumbRadius: sliderConfig.thumbRadius,
          overlayRadius: sliderConfig.overlayRadius,
          thumbElevation: sliderConfig.thumbElevation,
          thumbShadowColor: sliderConfig.thumbShadowColor,
          thumbBorderWidth: sliderConfig.thumbBorderWidth,
          thumbBorderColor: sliderConfig.thumbBorderColor,
        ),
        BrandSelectionGroupTheme(
          showDividers: selectionGroupConfig.showDividers,
          dividerColor: selectionGroupConfig.dividerColor,
          dividerThickness: selectionGroupConfig.dividerThickness,
          dividerIndent: selectionGroupConfig.dividerIndent,
          showCard: selectionGroupConfig.showCard,
          cardBackgroundColor: selectionGroupConfig.cardBackgroundColor,
        ),
        BrandTagTheme(
          readOnlyBackgroundColor: tagConfig.readOnlyBackgroundColor,
          readOnlyForegroundColor: tagConfig.readOnlyForegroundColor,
          readOnlyBorderColor: tagConfig.readOnlyBorderColor,
          unselectedBackgroundColor: tagConfig.unselectedBackgroundColor,
          unselectedForegroundColor: tagConfig.unselectedForegroundColor,
          unselectedBorderColor: tagConfig.unselectedBorderColor,
          selectedBackgroundColor: tagConfig.selectedBackgroundColor,
          selectedForegroundColor: tagConfig.selectedForegroundColor,
          selectedBorderColor: tagConfig.selectedBorderColor,
          selectableHeight: tagConfig.selectableHeight,
        ),
        BrandProgressBarTheme(
          activeColor: progressBarConfig.activeColor,
          activeGradient: progressBarConfig.activeGradient,
          inactiveColor: progressBarConfig.inactiveColor,
          counterTextColor: progressBarConfig.counterTextColor,
          height: progressBarConfig.height,
          borderRadius: progressBarConfig.borderRadius,
        ),
        BrandScreenLayoutTheme(
          dividerColor: screenLayoutConfig.dividerColor,
          dividerThickness: screenLayoutConfig.dividerThickness,
          scrollGradientColor: screenLayoutConfig.scrollGradientColor,
          scrollGradientHeight: screenLayoutConfig.scrollGradientHeight,
          backgroundColor: colors.background,
        ),
        BrandLandingScreenTheme(
          mobileLogoAlignment: landingScreenConfig.mobileLogoAlignment,
          mobileLogoPaddingTop: landingScreenConfig.mobileLogoPaddingTop,
          mobileLogoPaddingBottom: landingScreenConfig.mobileLogoPaddingBottom,
          mobileLogoPaddingHorizontal: landingScreenConfig.mobileLogoPaddingHorizontal,
          mobileBackgroundColor: landingScreenConfig.mobileBackgroundColor,
          desktopCardMaxWidth: landingScreenConfig.desktopCardMaxWidth,
          desktopTopBarHeight: landingScreenConfig.desktopTopBarHeight,
          desktopTopBarPaddingHorizontal: landingScreenConfig.desktopTopBarPaddingHorizontal,
          desktopTopBarPaddingVertical: landingScreenConfig.desktopTopBarPaddingVertical,
          desktopTopBarBackgroundColor: landingScreenConfig.desktopTopBarBackgroundColor,
          desktopTopBarBoxShadow: landingScreenConfig.desktopTopBarBoxShadow,
          desktopCardBackgroundColor: landingScreenConfig.desktopCardBackgroundColor,
          desktopCardBorderRadius: landingScreenConfig.desktopCardBorderRadius,
          desktopCardElevation: landingScreenConfig.desktopCardElevation,
          desktopCardPadding: landingScreenConfig.desktopCardPadding,
          mobileBreakpoint: landingScreenConfig.mobileBreakpoint,
        ),
        BrandLogoTheme(
          smallHeight: logoConfig.smallHeight,
          largeHeight: logoConfig.largeHeight,
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
      textTheme: _buildTextTheme(typographyConfig, inputConfig),
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
        disabledBorder:
            getBorder(inputConfig.inactiveBorderColor ?? Colors.grey),
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

  /// Construit le TextTheme avec les polices personnalisées selon la configuration
  static TextTheme _buildTextTheme(
    BrandTypographyConfig typographyConfig,
    BrandInputConfig inputConfig,
  ) {
    // Couleurs par défaut
    final defaultHeadlineColor =
        typographyConfig.headlineColor ?? Colors.black87;
    final defaultTitleColor = typographyConfig.titleColor ?? Colors.black87;

    // Poids de police par défaut
    final defaultHeadlineFontWeight =
        typographyConfig.headlineFontWeight ?? FontWeight.w400;
    final defaultTitleFontWeight =
        typographyConfig.titleFontWeight ?? FontWeight.w500;

    // Fonction helper pour obtenir un TextStyle avec la police Google Fonts
    TextStyle getTextStyle({
      required double fontSize,
      required FontWeight fontWeight,
      required Color color,
      String? fontFamily,
    }) {
      if (fontFamily != null && fontFamily.isNotEmpty) {
        return GoogleFonts.getFont(
          fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
      }
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
    }

    return TextTheme(
      // Display styles - très grands titres
      displayLarge: getTextStyle(
        fontSize: 57,
        fontWeight: defaultHeadlineFontWeight,
        color: defaultHeadlineColor,
        fontFamily: typographyConfig.headlineFontFamily,
      ),
      displayMedium: getTextStyle(
        fontSize: 45,
        fontWeight: defaultHeadlineFontWeight,
        color: defaultHeadlineColor,
        fontFamily: typographyConfig.headlineFontFamily,
      ),
      displaySmall: getTextStyle(
        fontSize: 36,
        fontWeight: defaultHeadlineFontWeight,
        color: defaultHeadlineColor,
        fontFamily: typographyConfig.headlineFontFamily,
      ),

      // Headline styles - titres principaux (h1, h2, h3)
      headlineLarge: getTextStyle(
        fontSize: 32,
        fontWeight: defaultHeadlineFontWeight,
        color: defaultHeadlineColor,
        fontFamily: typographyConfig.headlineFontFamily,
      ),
      headlineMedium: getTextStyle(
        fontSize: 28,
        fontWeight: typographyConfig.headlineMediumFontWeight ??
            defaultHeadlineFontWeight,
        color: defaultHeadlineColor,
        fontFamily: typographyConfig.headlineFontFamily,
      ),
      headlineSmall: getTextStyle(
        fontSize: typographyConfig.headlineSmallFontSize ?? 24,
        fontWeight: typographyConfig.headlineSmallFontWeight ??
            defaultHeadlineFontWeight,
        color: defaultHeadlineColor,
        fontFamily: typographyConfig.headlineSmallFontFamily ??
            typographyConfig.headlineFontFamily,
      ),

      // Title styles - titres secondaires (h4, h5, h6)
      titleLarge: getTextStyle(
        fontSize: 22,
        fontWeight: defaultTitleFontWeight,
        color: defaultTitleColor,
        fontFamily: typographyConfig.titleFontFamily,
      ),
      titleMedium: getTextStyle(
        fontSize: 16,
        fontWeight: defaultTitleFontWeight,
        color: defaultTitleColor,
        fontFamily: typographyConfig.titleFontFamily,
      ),
      titleSmall: getTextStyle(
        fontSize: 14,
        fontWeight: defaultTitleFontWeight,
        color: defaultTitleColor,
        fontFamily: typographyConfig.titleFontFamily,
      ),

      // Body styles - corps de texte
      bodyLarge: getTextStyle(
        fontSize: 16,
        fontWeight: inputConfig.textFontWeight ?? FontWeight.normal,
        color: inputConfig.textColor ?? Colors.black87,
        fontFamily: typographyConfig.bodyFontFamily,
      ),
      bodyMedium: getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        fontFamily: typographyConfig.bodyFontFamily,
      ),
      bodySmall: getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        fontFamily: typographyConfig.bodyFontFamily,
      ),

      // Label styles - labels et petits textes
      labelLarge: getTextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        fontFamily: typographyConfig.labelFontFamily,
      ),
      labelMedium: getTextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        fontFamily: typographyConfig.labelFontFamily,
      ),
      labelSmall: getTextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        fontFamily: typographyConfig.labelFontFamily,
      ),
    );
  }
}
