import 'package:flutter/material.dart';
import '../theme/brand_theme_extensions.dart';
import 'button_eae.dart';

class SelectableButtonEAE extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onChanged;
  final ButtonEAESize size;
  final IconData? icon;
  final bool isFullWidth;

  const SelectableButtonEAE({
    Key? key,
    required this.label,
    required this.isSelected,
    this.onChanged,
    this.size = ButtonEAESize.medium,
    this.icon,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectableTheme = theme.extension<BrandSelectableButtonTheme>();

    // Determine styles based on selection state
    final Color? backgroundColor;
    final Color? foregroundColor;
    final BorderSide? borderSide;
    final ButtonEAEVariant variant;

    if (isSelected) {
      // Selected state
      variant = ButtonEAEVariant.primary;

      // Check for custom selected overrides
      backgroundColor = selectableTheme
          ?.selectedBackgroundColor; // If null, uses variant default
      foregroundColor = selectableTheme
          ?.selectedForegroundColor; // If null, uses variant default

      if (selectableTheme?.selectedBorderColor != null) {
        borderSide = BorderSide(
          color: selectableTheme!.selectedBorderColor!,
          width: selectableTheme.selectedBorderWidth > 0
              ? selectableTheme.selectedBorderWidth
              : 1.0,
        );
      } else {
        borderSide = null; // Use variant default (none for primary)
      }
    } else {
      // Unselected state
      variant = ButtonEAEVariant.outline;

      // Check for custom unselected overrides
      backgroundColor =
          selectableTheme?.unselectedBackgroundColor ?? Colors.transparent;
      foregroundColor = selectableTheme?.unselectedTextColor;

      if (selectableTheme?.unselectedBorderColor != null) {
        borderSide = BorderSide(
            color: selectableTheme!.unselectedBorderColor!,
            width: selectableTheme.unselectedBorderWidth);
      } else {
        borderSide = null;
      }
    }

    return ButtonEAE(
      label: label,
      onPressed: onChanged != null ? () => onChanged!(!isSelected) : null,
      variant: variant,
      size: size,
      icon: icon,
      isFullWidth: isFullWidth,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderSide: borderSide,
    );
  }
}
