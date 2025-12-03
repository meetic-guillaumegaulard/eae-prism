/// Utilitaire pour construire les URLs de l'API EAE
/// 
/// Cette classe centralise la configuration de l'API backend et fournit
/// des méthodes pour construire les URLs des différentes ressources.
class ApiUtils {
  /// URL de base de l'API
  /// TODO: Rendre configurable via variables d'environnement
  static const String baseUrl = 'http://localhost:3000/api';

  /// Construit une URL pour les assets de marque
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  /// [assetPath] Le chemin de l'asset (ex: logo-small.png)
  static String brandAssetUrl(String brandName, String assetPath) {
    return '$baseUrl/assets/brands/$brandName/$assetPath';
  }

  /// Construit l'URL du logo selon le type
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  /// [logoType] Le type de logo (small, onDark, onWhite)
  static String logoUrl(String brandName, LogoType logoType) {
    final fileName = switch (logoType) {
      LogoType.small => 'logo-small.png',
      LogoType.onDark => 'logo-ondark.png',
      LogoType.onWhite => 'logo-onwhite.png',
    };
    return brandAssetUrl(brandName, fileName);
  }

  /// Construit l'URL de l'image de fond landing mobile
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  static String landingMobileBackgroundUrl(String brandName) {
    return brandAssetUrl(brandName, 'landing-mobile.jpg');
  }

  /// Construit l'URL de l'image de fond landing desktop
  /// 
  /// [brandName] Le nom de la marque (match, meetic, okc, pof)
  static String landingDesktopBackgroundUrl(String brandName) {
    return brandAssetUrl(brandName, 'landing-desktop.jpg');
  }
}

/// Types de logos disponibles
enum LogoType {
  /// Logo compact/icône
  small,
  /// Logo pour fond sombre
  onDark,
  /// Logo pour fond clair
  onWhite,
}

