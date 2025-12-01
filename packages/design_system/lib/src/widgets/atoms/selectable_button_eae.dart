import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';
import 'button_eae.dart';
import 'radio_button_eae.dart';

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
    final showRadioButton = selectableTheme?.showRadioButton ?? false;

    // Determine styles based on selection state
    final Color? backgroundColor;
    final Color? foregroundColor;
    final BorderSide? borderSide;
    final ButtonEAEVariant variant;

    // Calculate effective border widths for layout stability
    // We need to ensure the total size (content + padding + border) remains constant
    // by adjusting padding to compensate for border width changes.

    double effectiveSelectedBorderWidth = 0.0;
    if (selectableTheme?.selectedBorderColor != null) {
      effectiveSelectedBorderWidth =
          (selectableTheme?.selectedBorderWidth ?? 0) > 0
              ? selectableTheme!.selectedBorderWidth
              : 1.0;
    }

    double effectiveUnselectedBorderWidth = 0.0;
    if (selectableTheme?.unselectedBorderColor != null) {
      effectiveUnselectedBorderWidth =
          (selectableTheme?.unselectedBorderWidth ?? 0) > 0
              ? selectableTheme!.unselectedBorderWidth
              : 1.0; // Default assumption if width is 0 but color is present?
      // Actually config defaults unselectedBorderWidth to 1.0.
    } else {
      // If no unselected border color, usually no border, so width 0.
      effectiveUnselectedBorderWidth = 0.0;
    }

    final double maxBorderWidth =
        effectiveSelectedBorderWidth > effectiveUnselectedBorderWidth
            ? effectiveSelectedBorderWidth
            : effectiveUnselectedBorderWidth;

    final double currentBorderWidth = isSelected
        ? effectiveSelectedBorderWidth
        : effectiveUnselectedBorderWidth;
    final double borderDelta = maxBorderWidth - currentBorderWidth;

    if (isSelected) {
      // Selected state
      variant = ButtonEAEVariant.primary;

      // Check for custom selected overrides
      backgroundColor = selectableTheme?.selectedBackgroundColor;
      foregroundColor = selectableTheme?.selectedForegroundColor;

      if (selectableTheme?.selectedBorderColor != null) {
        borderSide = BorderSide(
          color: selectableTheme!.selectedBorderColor!,
          width: effectiveSelectedBorderWidth,
        );
      } else {
        borderSide = null;
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

    // Check for custom padding overrides and apply stability adjustment
    final elevatedButtonTheme = theme.elevatedButtonTheme.style;
    final defaultPadding =
        elevatedButtonTheme?.padding?.resolve({}) as EdgeInsets? ??
            const EdgeInsets.symmetric(horizontal: 32, vertical: 12);

    double baseHorizontal = defaultPadding.horizontal / 2;
    double baseVertical = defaultPadding.vertical / 2;

    if (selectableTheme?.horizontalPadding != null) {
      baseHorizontal = selectableTheme!.horizontalPadding!;
    }
    if (selectableTheme?.verticalPadding != null) {
      baseVertical = selectableTheme!.verticalPadding!;
    }

    // Determine scale factor used by ButtonEAE to reverse-engineer the input padding
    double horizontalScale = 1.0;
    switch (size) {
      case ButtonEAESize.small:
        horizontalScale = 0.75;
        break;
      case ButtonEAESize.medium:
        horizontalScale = 1.0;
        break;
      case ButtonEAESize.large:
        horizontalScale = 1.25;
        break;
    }

    // Apply adjustment: Add delta to padding to compensate for thinner border
    final adjustedHorizontal = baseHorizontal + (borderDelta / horizontalScale);
    final adjustedVertical = baseVertical + borderDelta;

    final contentPadding = EdgeInsets.symmetric(
      horizontal: adjustedHorizontal,
      vertical: adjustedVertical,
    );

    // If we need to show a radio button, we can't just pass label/icon to ButtonEAE directly
    // because ButtonEAE centers content. We need a custom child content.
    // But ButtonEAE doesn't accept 'child', only label/icon.
    // We might need to modify ButtonEAE to accept a custom child OR utilize its Row layout if possible.
    // Actually, ButtonEAE is simple. Let's wrap ButtonEAE or modifying it?
    //
    // Better approach: Since SelectableButtonEAE delegates to ButtonEAE, let's see if we can
    // pass the Radio Button as an Icon? No, Radio is a widget.
    //
    // Let's modify ButtonEAE to accept a 'trailing' widget. That's cleaner.

    // For now, let's assume ButtonEAE stays as is.
    // Wait, SelectableButtonEAE *is* the composition root here.
    // If I want a Radio at the end, I should probably pass it as a custom child to ButtonEAE if it supported it.
    // Since it doesn't, I'll modify ButtonEAE to accept a `trailing` widget.

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
      contentPadding: contentPadding,
      trailing: showRadioButton
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: RadioButtonEAE<bool>(
                value: true,
                groupValue: isSelected ? true : false,
                onChanged: null, // Passive mode
              ),
            )
          : null,
      // We also need to make sure content alignment is correct. ButtonEAE usually centers content.
      // For a list item like "One night ... O", usually text is left, radio is right.
      // We might need a new property in ButtonEAE for alignment.
      mainAxisAlignment: showRadioButton
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
    );
  }
}
