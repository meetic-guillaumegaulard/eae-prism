import 'package:flutter/material.dart';
import '../../../theme/brand_theme_extensions.dart';

/// Tailles standardisées pour les icônes
enum IconSizeEAE {
  /// Extra small - 16px
  xs,

  /// Small - 20px
  sm,

  /// Medium - 24px (default)
  md,

  /// Large - 32px
  lg,

  /// Extra large - 48px
  xl,
}

/// Composant d'icône standardisé du design system.
///
/// Utilise les Material Icons intégrés à Flutter avec des tailles
/// et couleurs standardisées par marque.
///
/// Exemples d'utilisation :
/// ```dart
/// // Icône simple avec taille par défaut
/// IconEAE(Icons.favorite)
///
/// // Icône avec taille spécifique
/// IconEAE(Icons.home, size: IconSizeEAE.lg)
///
/// // Icône avec couleur personnalisée
/// IconEAE(Icons.star, color: Colors.amber)
///
/// // Icône avec taille en pixels personnalisée
/// IconEAE.custom(Icons.settings, size: 28)
/// ```
class IconEAE extends StatelessWidget {
  /// L'icône à afficher (Material Icons)
  final IconData icon;

  /// Taille standardisée de l'icône
  final IconSizeEAE? sizeEnum;

  /// Taille personnalisée en pixels (prioritaire sur sizeEnum)
  final double? customSize;

  /// Couleur de l'icône (utilise la couleur du thème si non spécifiée)
  final Color? color;

  /// Sémantique pour l'accessibilité
  final String? semanticLabel;

  /// Direction du texte pour les icônes directionnelles
  final TextDirection? textDirection;

  /// Crée une icône avec une taille standardisée.
  const IconEAE(
    this.icon, {
    Key? key,
    this.sizeEnum = IconSizeEAE.md,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : customSize = null,
        super(key: key);

  /// Crée une icône avec une taille personnalisée en pixels.
  const IconEAE.custom(
    this.icon, {
    Key? key,
    required double size,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : customSize = size,
        sizeEnum = null,
        super(key: key);

  /// Constructeurs raccourcis pour les tailles courantes
  const IconEAE.xs(
    this.icon, {
    Key? key,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : sizeEnum = IconSizeEAE.xs,
        customSize = null,
        super(key: key);

  const IconEAE.sm(
    this.icon, {
    Key? key,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : sizeEnum = IconSizeEAE.sm,
        customSize = null,
        super(key: key);

  const IconEAE.md(
    this.icon, {
    Key? key,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : sizeEnum = IconSizeEAE.md,
        customSize = null,
        super(key: key);

  const IconEAE.lg(
    this.icon, {
    Key? key,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : sizeEnum = IconSizeEAE.lg,
        customSize = null,
        super(key: key);

  const IconEAE.xl(
    this.icon, {
    Key? key,
    this.color,
    this.semanticLabel,
    this.textDirection,
  })  : sizeEnum = IconSizeEAE.xl,
        customSize = null,
        super(key: key);

  /// Convertit l'enum de taille en pixels
  static double getSizeInPixels(IconSizeEAE size) {
    return switch (size) {
      IconSizeEAE.xs => 16.0,
      IconSizeEAE.sm => 20.0,
      IconSizeEAE.md => 24.0,
      IconSizeEAE.lg => 32.0,
      IconSizeEAE.xl => 48.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).extension<BrandIconTheme>();
    final defaultColor = iconTheme?.defaultColor ??
        Theme.of(context).iconTheme.color ??
        Theme.of(context).colorScheme.onSurface;

    // Détermine la taille finale
    final double finalSize;
    if (customSize != null) {
      finalSize = customSize!;
    } else {
      finalSize = getSizeInPixels(sizeEnum ?? IconSizeEAE.md);
    }

    return Icon(
      icon,
      size: finalSize,
      color: color ?? defaultColor,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

/// Widget pour afficher une icône dans un conteneur circulaire
class IconCircleEAE extends StatelessWidget {
  /// L'icône à afficher
  final IconData icon;

  /// Taille de l'icône
  final IconSizeEAE iconSize;

  /// Couleur de l'icône
  final Color? iconColor;

  /// Couleur de fond du cercle
  final Color? backgroundColor;

  /// Padding autour de l'icône
  final double padding;

  /// Sémantique pour l'accessibilité
  final String? semanticLabel;

  const IconCircleEAE({
    Key? key,
    required this.icon,
    this.iconSize = IconSizeEAE.md,
    this.iconColor,
    this.backgroundColor,
    this.padding = 8.0,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).extension<BrandIconTheme>();
    final defaultBgColor = iconTheme?.circleBackgroundColor ??
        Theme.of(context).colorScheme.primaryContainer;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? defaultBgColor,
        shape: BoxShape.circle,
      ),
      child: IconEAE(
        icon,
        sizeEnum: iconSize,
        color: iconColor,
        semanticLabel: semanticLabel,
      ),
    );
  }
}

/// Widget pour afficher une icône avec un badge (compteur)
class IconBadgeEAE extends StatelessWidget {
  /// L'icône à afficher
  final IconData icon;

  /// Taille de l'icône
  final IconSizeEAE iconSize;

  /// Couleur de l'icône
  final Color? iconColor;

  /// Valeur du badge (affiche un point si null)
  final int? badgeValue;

  /// Couleur du badge
  final Color? badgeColor;

  /// Couleur du texte du badge
  final Color? badgeTextColor;

  /// Afficher le badge même si la valeur est 0
  final bool showZero;

  /// Sémantique pour l'accessibilité
  final String? semanticLabel;

  const IconBadgeEAE({
    Key? key,
    required this.icon,
    this.iconSize = IconSizeEAE.md,
    this.iconColor,
    this.badgeValue,
    this.badgeColor,
    this.badgeTextColor,
    this.showZero = false,
    this.semanticLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconTheme = Theme.of(context).extension<BrandIconTheme>();
    final defaultBadgeColor =
        iconTheme?.badgeColor ?? Theme.of(context).colorScheme.error;
    final defaultBadgeTextColor =
        iconTheme?.badgeTextColor ?? Theme.of(context).colorScheme.onError;

    final shouldShowBadge =
        badgeValue == null || badgeValue! > 0 || showZero;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconEAE(
          icon,
          sizeEnum: iconSize,
          color: iconColor,
          semanticLabel: semanticLabel,
        ),
        if (shouldShowBadge)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: EdgeInsets.all(badgeValue == null ? 0 : 4),
              constraints: BoxConstraints(
                minWidth: badgeValue == null ? 8 : 16,
                minHeight: badgeValue == null ? 8 : 16,
              ),
              decoration: BoxDecoration(
                color: badgeColor ?? defaultBadgeColor,
                shape: BoxShape.circle,
              ),
              child: badgeValue != null
                  ? Center(
                      child: Text(
                        badgeValue! > 99 ? '99+' : badgeValue.toString(),
                        style: TextStyle(
                          color: badgeTextColor ?? defaultBadgeTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}

