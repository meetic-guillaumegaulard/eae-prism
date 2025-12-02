import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

enum TagEAESize {
  small,
  medium,
  large,
}

enum TagEAEVariant {
  filled,
}

class TagEAE extends StatefulWidget {
  final String label;
  final TagEAESize size;
  final TagEAEVariant variant;
  final IconData? icon;

  // Mode lecture seule avec suppression
  final VoidCallback? onDelete;

  // Mode sélectionnable
  final bool? isSelected;
  final ValueChanged<bool>? onSelectedChanged;

  // Customisation des couleurs
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  // Customisation des couleurs pour l'état sélectionné
  final Color? selectedBackgroundColor;
  final Color? selectedForegroundColor;
  final Color? selectedBorderColor;

  const TagEAE({
    Key? key,
    required this.label,
    this.size = TagEAESize.medium,
    this.variant = TagEAEVariant.filled,
    this.icon,
    this.onDelete,
    this.isSelected,
    this.onSelectedChanged,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedBorderColor,
  })  : assert(
          onDelete == null || (isSelected == null && onSelectedChanged == null),
          'Cannot have both onDelete and selectable mode (isSelected/onSelectedChanged)',
        ),
        super(key: key);

  @override
  State<TagEAE> createState() => _TagEAEState();
}

class _TagEAEState extends State<TagEAE> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tagTheme = theme.extension<BrandTagTheme>();

    // Détermine si le tag est en mode sélectionnable ou lecture seule avec état
    final bool hasSelectionState = widget.isSelected != null;
    final bool isInteractive = widget.onSelectedChanged != null;
    final bool selected = widget.isSelected ?? false;

    // Size configuration
    final double horizontalPadding;
    final double verticalPadding;
    final double fontSize;
    final double iconSize;
    const double borderRadius = 999.0; // Capsule shape pour tous les tags

    // Hauteur fixe pour les tags sélectionnables si définie dans le thème
    final double? fixedSelectableHeight =
        hasSelectionState ? tagTheme?.selectableHeight : null;

    // Padding vertical plus important en mode sélectionnable (sauf si hauteur fixe)
    final bool hasIncreasedPadding =
        hasSelectionState && fixedSelectableHeight == null;

    switch (widget.size) {
      case TagEAESize.small:
        horizontalPadding = 8;
        verticalPadding = hasIncreasedPadding ? 8 : 4;
        fontSize = 12;
        iconSize = 12;
        break;
      case TagEAESize.medium:
        horizontalPadding = 12;
        verticalPadding = hasIncreasedPadding ? 10 : 6;
        fontSize = 14;
        iconSize = 14;
        break;
      case TagEAESize.large:
        horizontalPadding = 16;
        verticalPadding = hasIncreasedPadding ? 12 : 8;
        fontSize = 16;
        iconSize = 16;
        break;
    }

    // Style configuration based on variant and selection state
    final Color effectiveBackgroundColor;
    final Color effectiveForegroundColor;
    final Color? effectiveBorderColor;
    final double borderWidth;

    if (hasSelectionState && selected) {
      // État sélectionné (interactif ou non)
      effectiveBackgroundColor = widget.selectedBackgroundColor ??
          tagTheme?.selectedBackgroundColor ??
          colorScheme.primary;
      effectiveForegroundColor = widget.selectedForegroundColor ??
          tagTheme?.selectedForegroundColor ??
          colorScheme.onPrimary;
      effectiveBorderColor =
          widget.selectedBorderColor ?? tagTheme?.selectedBorderColor;
      borderWidth = effectiveBorderColor != null ? 1 : 0;
    } else if (hasSelectionState && !selected) {
      // État non sélectionné (interactif ou non)
      effectiveBackgroundColor = widget.backgroundColor ??
          tagTheme?.unselectedBackgroundColor ??
          Colors.grey.shade200;
      effectiveForegroundColor = widget.foregroundColor ??
          tagTheme?.unselectedForegroundColor ??
          Colors.grey.shade700;
      effectiveBorderColor = tagTheme?.unselectedBorderColor;
      borderWidth = effectiveBorderColor != null ? 1 : 0;
    } else {
      // Mode lecture seule sans état de sélection
      effectiveBackgroundColor = widget.backgroundColor ??
          tagTheme?.readOnlyBackgroundColor ??
          colorScheme.primary;
      effectiveForegroundColor = widget.foregroundColor ??
          tagTheme?.readOnlyForegroundColor ??
          colorScheme.onPrimary;
      effectiveBorderColor =
          widget.borderColor ?? tagTheme?.readOnlyBorderColor;
      borderWidth = effectiveBorderColor != null ? 1 : 0;
    }

    final tagContent = Container(
      height: fixedSelectableHeight,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: fixedSelectableHeight != null ? 0 : verticalPadding,
      ),
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: effectiveBorderColor != null
            ? Border.all(color: effectiveBorderColor, width: borderWidth)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              size: iconSize,
              color: effectiveForegroundColor,
            ),
            SizedBox(width: widget.size == TagEAESize.small ? 4 : 6),
          ],
          Flexible(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: effectiveForegroundColor,
                height:
                    1.2, // Hauteur de ligne contrôlée pour éviter le padding bizarre
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.onDelete != null) ...[
            SizedBox(width: widget.size == TagEAESize.small ? 4 : 6),
            GestureDetector(
              onTap: widget.onDelete,
              child: Icon(
                Icons.close,
                size: iconSize,
                color: effectiveForegroundColor,
              ),
            ),
          ],
        ],
      ),
    );

    // Si le tag est interactif, on l'entoure d'un GestureDetector
    if (hasSelectionState && isInteractive) {
      return GestureDetector(
        onTap: () => widget.onSelectedChanged?.call(!selected),
        child: tagContent,
      );
    }

    return tagContent;
  }
}
