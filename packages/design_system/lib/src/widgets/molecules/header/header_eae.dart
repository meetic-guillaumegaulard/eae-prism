import 'package:flutter/material.dart';
import '../../../theme/brand_theme_extensions.dart';
import '../../atoms/icon/icon_eae.dart';

/// Composant header molécule pour les écrans.
///
/// Affiche une icône et un texte, avec un bouton back optionnel.
/// L'icône est également affichée en grand format en arrière-plan à droite.
/// L'icône du bouton back et les couleurs sont configurables par brand via le thème.
///
/// Exemples d'utilisation :
/// ```dart
/// // Header simple sans bouton back
/// HeaderEAE(
///   icon: Icons.calendar_today,
///   text: 'Your date of birth',
/// )
///
/// // Header avec bouton back
/// HeaderEAE(
///   icon: Icons.calendar_today,
///   text: 'Your date of birth',
///   onBack: () => Navigator.of(context).pop(),
/// )
/// ```
class HeaderEAE extends StatelessWidget {
  /// L'icône principale à afficher
  final IconData icon;

  /// Le texte du header
  final String text;

  /// Callback appelé quand le bouton back est pressé.
  /// Si null, le bouton back n'est pas affiché.
  final VoidCallback? onBack;

  /// Taille de l'icône principale
  final IconSizeEAE iconSize;

  /// Taille de l'icône back
  final double backIconSize;

  /// Override de la couleur (utilise la couleur du thème si non spécifiée)
  final Color? foregroundColor;

  /// Style du texte (utilise le style du thème si non spécifié)
  final TextStyle? textStyle;

  /// Override de la couleur de fond (utilise la couleur du thème si non spécifiée)
  final Color? backgroundColor;

  /// Affiche l'icône décorative en arrière-plan (true par défaut)
  final bool showBackgroundIcon;

  /// Taille de l'icône décorative en arrière-plan
  final double backgroundIconSize;

  /// Opacité de l'icône décorative en arrière-plan
  final double backgroundIconOpacity;

  const HeaderEAE({
    Key? key,
    required this.icon,
    required this.text,
    this.onBack,
    this.iconSize = IconSizeEAE.lg,
    this.backIconSize = 28.0,
    this.foregroundColor,
    this.backgroundColor,
    this.textStyle,
    this.showBackgroundIcon = true,
    this.backgroundIconSize = 200.0,
    this.backgroundIconOpacity = 0.15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerTheme = Theme.of(context).extension<BrandHeaderTheme>();
    final theme = Theme.of(context);

    // Couleur de premier plan (texte et icônes)
    final effectiveForegroundColor = foregroundColor ??
        headerTheme?.foregroundColor ??
        theme.colorScheme.onSurface;

    // Couleur de fond
    final effectiveBackgroundColor = backgroundColor ??
        headerTheme?.backgroundColor;

    // Icône du bouton back
    final backIcon = headerTheme?.backIcon ?? Icons.chevron_left;

    // Espacements
    final iconTextSpacing = headerTheme?.iconTextSpacing ?? 12.0;
    final verticalPadding = headerTheme?.verticalPadding ?? 16.0;
    final horizontalPadding = headerTheme?.horizontalPadding ?? 16.0;

    // Style du texte
    final effectiveTextStyle = textStyle ??
        theme.textTheme.titleLarge?.copyWith(
          color: effectiveForegroundColor,
          fontWeight: FontWeight.w400,
        ) ??
        TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: effectiveForegroundColor,
        );

    return Container(
      color: effectiveBackgroundColor,
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
          // Icône décorative en arrière-plan (grande, rognée en bas à droite)
          if (showBackgroundIcon)
            Positioned(
              right: -backgroundIconSize * 0.25,
              bottom: -backgroundIconSize * 0.35,
              child: Icon(
                icon,
                size: backgroundIconSize,
                color: effectiveForegroundColor.withValues(alpha: backgroundIconOpacity),
              ),
            ),
          // Contenu principal
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bouton back (si onBack est fourni)
                if (onBack != null) ...[
                  GestureDetector(
                    onTap: onBack,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Icon(
                        backIcon,
                        size: backIconSize,
                        color: effectiveForegroundColor,
                      ),
                    ),
                  ),
                ],
                // Icône principale + texte
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconEAE(
                      icon,
                      sizeEnum: iconSize,
                      color: effectiveForegroundColor,
                    ),
                    SizedBox(width: iconTextSpacing),
                    Expanded(
                      child: Text(
                        text,
                        style: effectiveTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
