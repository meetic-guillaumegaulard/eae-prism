import 'package:flutter/material.dart';
import '../../../models/brand.dart';
import '../../../utils/api_utils.dart';
import '../../../theme/brand_theme_extensions.dart';

/// Widget pour afficher le logo de la marque
/// 
/// Le logo est chargé depuis l'API backend et s'adapte automatiquement
/// au type de fond (clair/sombre) ou utilise le type small pour les espaces réduits.
/// 
/// Exemple d'utilisation:
/// ```dart
/// // Logo adapté au fond (onWhite par défaut)
/// LogoEAE(brand: Brand.meetic)
/// 
/// // Logo pour fond sombre
/// LogoEAE(brand: Brand.meetic, type: LogoTypeEAE.onDark)
/// 
/// // Logo compact
/// LogoEAE(brand: Brand.meetic, type: LogoTypeEAE.small)
/// 
/// // Logo avec hauteur personnalisée
/// LogoEAE(brand: Brand.meetic, height: 80)
/// ```
class LogoEAE extends StatelessWidget {
  /// La marque dont on veut afficher le logo
  final Brand brand;

  /// Le type de logo à afficher
  /// - [LogoTypeEAE.small] : Logo compact/icône
  /// - [LogoTypeEAE.onDark] : Logo pour fond sombre (texte clair)
  /// - [LogoTypeEAE.onWhite] : Logo pour fond clair (texte sombre)
  final LogoTypeEAE type;

  /// Hauteur personnalisée du logo (optionnelle)
  /// Si non spécifiée, utilise la hauteur par défaut du thème
  final double? height;

  /// Couleur de fond pour le placeholder de chargement
  final Color? placeholderColor;

  /// Widget personnalisé à afficher pendant le chargement
  final Widget? loadingWidget;

  /// Widget personnalisé à afficher en cas d'erreur
  final Widget? errorWidget;

  /// BoxFit pour l'image
  final BoxFit fit;

  /// Qualité de filtrage pour le redimensionnement
  /// Par défaut sur high pour éviter la pixelisation
  final FilterQuality filterQuality;

  const LogoEAE({
    super.key,
    required this.brand,
    this.type = LogoTypeEAE.onWhite,
    this.height,
    this.placeholderColor,
    this.loadingWidget,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.high,
  });

  /// Constructeur raccourci pour le logo small
  const LogoEAE.small({
    super.key,
    required this.brand,
    this.height,
    this.placeholderColor,
    this.loadingWidget,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.high,
  }) : type = LogoTypeEAE.small;

  /// Constructeur raccourci pour le logo sur fond sombre
  const LogoEAE.onDark({
    super.key,
    required this.brand,
    this.height,
    this.placeholderColor,
    this.loadingWidget,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.high,
  }) : type = LogoTypeEAE.onDark;

  /// Constructeur raccourci pour le logo sur fond clair
  const LogoEAE.onWhite({
    super.key,
    required this.brand,
    this.height,
    this.placeholderColor,
    this.loadingWidget,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.filterQuality = FilterQuality.high,
  }) : type = LogoTypeEAE.onWhite;

  /// Convertit le nom de la brand en nom utilisable pour l'URL
  String _getBrandName() {
    return switch (brand) {
      Brand.match => 'match',
      Brand.meetic => 'meetic',
      Brand.okc => 'okc',
      Brand.pof => 'pof',
    };
  }

  /// Convertit le type de logo EAE vers le type API
  LogoType _getApiLogoType() {
    return switch (type) {
      LogoTypeEAE.small => LogoType.small,
      LogoTypeEAE.onDark => LogoType.onDark,
      LogoTypeEAE.onWhite => LogoType.onWhite,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final logoTheme = theme.extension<BrandLogoTheme>();

    // Déterminer la hauteur à utiliser
    final effectiveHeight = height ?? _getDefaultHeight(logoTheme);

    // Construire l'URL du logo
    final logoUrl = ApiUtils.logoUrl(_getBrandName(), _getApiLogoType());

    return SizedBox(
      height: effectiveHeight,
      child: Image.network(
        logoUrl,
        height: effectiveHeight,
        fit: fit,
        filterQuality: filterQuality,
        isAntiAlias: true,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ?? _buildDefaultLoadingWidget(effectiveHeight);
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildDefaultErrorWidget(effectiveHeight);
        },
      ),
    );
  }

  /// Récupère la hauteur par défaut selon le type de logo
  double _getDefaultHeight(BrandLogoTheme? logoTheme) {
    return switch (type) {
      LogoTypeEAE.small => logoTheme?.smallHeight ?? 60.0,
      LogoTypeEAE.onDark => logoTheme?.largeHeight ?? 60.0,
      LogoTypeEAE.onWhite => logoTheme?.largeHeight ?? 60.0,
    };
  }

  /// Widget par défaut pendant le chargement
  Widget _buildDefaultLoadingWidget(double height) {
    return SizedBox(
      height: height,
      width: height * 2, // Estimation d'un ratio largeur/hauteur
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: placeholderColor ?? Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  /// Widget par défaut en cas d'erreur
  Widget _buildDefaultErrorWidget(double height) {
    return SizedBox(
      height: height,
      child: Icon(
        Icons.broken_image_outlined,
        size: height * 0.5,
        color: Colors.grey.shade400,
      ),
    );
  }
}

/// Types de logos disponibles dans le design system
enum LogoTypeEAE {
  /// Logo compact/icône (pour la barre de navigation, favicon, etc.)
  small,
  /// Logo pour fond sombre (texte clair)
  onDark,
  /// Logo pour fond clair (texte sombre)
  onWhite,
}

