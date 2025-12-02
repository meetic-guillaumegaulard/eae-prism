import 'package:flutter/material.dart';

/// Type de texte correspondant aux niveaux de typographie
/// Équivalent HTML et Flutter:
/// - Display: Très grands titres (hero sections)
/// - Headline: Titres principaux (h1, h2, h3)
/// - Title: Titres secondaires (h4, h5, h6)
/// - Body: Corps de texte (p, span)
/// - Label: Labels et petits textes (small, caption)
enum TextTypeEAE {
  /// Titre principal très grand (équivalent hero/display)
  displayLarge,
  displayMedium,
  displaySmall,

  /// Titres principaux (équivalent h1, h2, h3)
  headlineLarge, // h1
  headlineMedium, // h2
  headlineSmall, // h3

  /// Titres secondaires (équivalent h4, h5, h6)
  titleLarge, // h4
  titleMedium, // h5
  titleSmall, // h6

  /// Corps de texte (équivalent paragraphe)
  bodyLarge, // p large
  bodyMedium, // p normal
  bodySmall, // p small

  /// Labels et petits textes
  labelLarge,
  labelMedium,
  labelSmall,
}

/// Widget de texte personnalisable selon la brand
/// 
/// Utilise automatiquement les styles de texte définis dans le thème de la brand.
/// Permet également de surcharger ces styles avec des paramètres personnalisés.
/// 
/// Exemple d'utilisation:
/// ```dart
/// TextEAE(
///   'Mon titre principal',
///   type: TextTypeEAE.headlineLarge,
/// )
/// 
/// TextEAE(
///   'Paragraphe de texte',
///   type: TextTypeEAE.bodyMedium,
///   color: Colors.red,
///   textAlign: TextAlign.center,
/// )
/// ```
class TextEAE extends StatelessWidget {
  final String text;
  final TextTypeEAE type;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextStyle? style; // Pour des surcharges complètes
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;

  const TextEAE(
    this.text, {
    super.key,
    this.type = TextTypeEAE.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  });

  /// Constructeur raccourci pour un titre principal (h1)
  const TextEAE.h1(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.headlineLarge;

  /// Constructeur raccourci pour un titre secondaire (h2)
  const TextEAE.h2(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.headlineMedium;

  /// Constructeur raccourci pour un titre tertiaire (h3)
  const TextEAE.h3(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.headlineSmall;

  /// Constructeur raccourci pour un titre h4
  const TextEAE.h4(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.titleLarge;

  /// Constructeur raccourci pour un titre h5
  const TextEAE.h5(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.titleMedium;

  /// Constructeur raccourci pour un titre h6
  const TextEAE.h6(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.titleSmall;

  /// Constructeur raccourci pour un paragraphe normal
  const TextEAE.body(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.bodyMedium;

  /// Constructeur raccourci pour un petit texte
  const TextEAE.small(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.bodySmall;

  /// Constructeur raccourci pour un label
  const TextEAE.label(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.fontStyle,
  }) : type = TextTypeEAE.labelMedium;

  /// Récupère le style de base selon le type de texte
  TextStyle _getBaseStyle(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    switch (type) {
      case TextTypeEAE.displayLarge:
        return textTheme.displayLarge ?? const TextStyle(fontSize: 57);
      case TextTypeEAE.displayMedium:
        return textTheme.displayMedium ?? const TextStyle(fontSize: 45);
      case TextTypeEAE.displaySmall:
        return textTheme.displaySmall ?? const TextStyle(fontSize: 36);
      case TextTypeEAE.headlineLarge:
        return textTheme.headlineLarge ?? const TextStyle(fontSize: 32);
      case TextTypeEAE.headlineMedium:
        return textTheme.headlineMedium ?? const TextStyle(fontSize: 28);
      case TextTypeEAE.headlineSmall:
        return textTheme.headlineSmall ?? const TextStyle(fontSize: 24);
      case TextTypeEAE.titleLarge:
        return textTheme.titleLarge ?? const TextStyle(fontSize: 22);
      case TextTypeEAE.titleMedium:
        return textTheme.titleMedium ?? const TextStyle(fontSize: 16);
      case TextTypeEAE.titleSmall:
        return textTheme.titleSmall ?? const TextStyle(fontSize: 14);
      case TextTypeEAE.bodyLarge:
        return textTheme.bodyLarge ?? const TextStyle(fontSize: 16);
      case TextTypeEAE.bodyMedium:
        return textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
      case TextTypeEAE.bodySmall:
        return textTheme.bodySmall ?? const TextStyle(fontSize: 12);
      case TextTypeEAE.labelLarge:
        return textTheme.labelLarge ?? const TextStyle(fontSize: 14);
      case TextTypeEAE.labelMedium:
        return textTheme.labelMedium ?? const TextStyle(fontSize: 12);
      case TextTypeEAE.labelSmall:
        return textTheme.labelSmall ?? const TextStyle(fontSize: 11);
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = _getBaseStyle(context);

    // Fusionne le style de base avec les surcharges
    final finalStyle = baseStyle.merge(style).copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          height: height,
          decoration: decoration,
          fontStyle: fontStyle,
        );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

