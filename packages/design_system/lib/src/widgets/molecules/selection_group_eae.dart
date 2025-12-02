import 'package:flutter/material.dart';
import '../atoms/checkbox_eae.dart';
import '../atoms/radio_button_eae.dart';
import '../../theme/brand_theme_extensions.dart';

/// Represents an option in the selection group
class SelectionOption<T> {
  final String label;
  final T value;

  const SelectionOption({
    required this.label,
    required this.value,
  });
}

/// Type of selection control (checkbox or radio button)
enum SelectionType {
  checkbox,
  radio,
}

/// A molecule component that manages a group of checkboxes or radio buttons
/// with an optional action item at the end (like "See all")
class SelectionGroupEAE<T> extends StatelessWidget {
  /// List of options to display
  final List<SelectionOption<T>> options;

  /// Type of selection control (checkbox or radio button)
  final SelectionType selectionType;

  /// Currently selected values (for checkboxes)
  final List<T>? selectedValues;

  /// Currently selected value (for radio buttons)
  final T? selectedValue;

  /// Callback when a checkbox is changed
  final ValueChanged<List<T>>? onCheckboxChanged;

  /// Callback when a radio button is changed
  final ValueChanged<T?>? onRadioChanged;

  /// Optional action item label (e.g., "See all")
  final String? actionLabel;

  /// Optional action item callback
  final VoidCallback? onActionTap;

  /// Spacing between items
  final double spacing;

  /// Whether to show chevron icon for action item
  final bool showActionChevron;

  /// Maximum number of selections allowed for checkboxes (null = unlimited)
  final int? maxSelections;

  /// Whether to show the card container with shadow (null = use theme default)
  final bool? showCard;

  /// Card border radius
  final double cardBorderRadius;

  /// Card padding
  final EdgeInsetsGeometry? cardPadding;

  /// Card shadow blur radius
  final double cardShadowBlur;

  /// Card shadow offset
  final Offset cardShadowOffset;

  /// Card background color (null = use theme default)
  final Color? cardBackgroundColor;

  const SelectionGroupEAE({
    Key? key,
    required this.options,
    required this.selectionType,
    this.selectedValues,
    this.selectedValue,
    this.onCheckboxChanged,
    this.onRadioChanged,
    this.actionLabel,
    this.onActionTap,
    this.spacing = 16.0,
    this.showActionChevron = true,
    this.maxSelections,
    this.showCard,
    this.cardBorderRadius = 8.0,
    this.cardPadding,
    this.cardShadowBlur = 8.0,
    this.cardShadowOffset = const Offset(0, 2),
    this.cardBackgroundColor,
  })  : assert(
          selectionType == SelectionType.checkbox
              ? (selectedValues != null && onCheckboxChanged != null)
              : (selectedValue != null || onRadioChanged != null),
          'For checkbox type, provide selectedValues and onCheckboxChanged. '
          'For radio type, provide selectedValue and onRadioChanged.',
        ),
        assert(
          (actionLabel != null && onActionTap != null) ||
              (actionLabel == null && onActionTap == null),
          'Both actionLabel and onActionTap must be provided together or not at all.',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final selectionGroupTheme = theme.extension<BrandSelectionGroupTheme>();

    // Use theme values as defaults if parameters are null
    final effectiveShowCard = showCard ?? selectionGroupTheme?.showCard ?? true;
    final effectiveCardBackgroundColor = cardBackgroundColor ??
        selectionGroupTheme?.cardBackgroundColor ??
        theme.colorScheme.surface;

    // Only show dividers if card is shown and theme has dividers enabled
    final showDividers =
        effectiveShowCard && (selectionGroupTheme?.showDividers ?? false);
    final dividerColor =
        selectionGroupTheme?.dividerColor ?? theme.dividerColor;
    final dividerThickness = selectionGroupTheme?.dividerThickness ?? 1.0;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display all options
        ...options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isLast = index == options.length - 1;

          return Column(
            children: [
              _buildOption(context, option, effectiveShowCard),
              if (!isLast) ...[
                if (showDividers)
                  Divider(
                    color: dividerColor,
                    thickness: dividerThickness,
                    height: spacing * 2,
                  )
                else
                  SizedBox(height: spacing),
              ],
            ],
          );
        }).toList(),

        // Display action item if provided
        if (actionLabel != null && onActionTap != null) ...[
          if (showDividers)
            Divider(
              color: dividerColor,
              thickness: dividerThickness,
              height: spacing * 2,
            )
          else
            SizedBox(height: spacing),
          _buildActionItem(context, theme, textTheme, effectiveShowCard),
        ],
      ],
    );

    if (!effectiveShowCard) {
      return content;
    }

    // Wrap in card container
    return Container(
      padding: cardPadding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: effectiveCardBackgroundColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: cardShadowBlur,
            offset: cardShadowOffset,
          ),
        ],
      ),
      child: content,
    );
  }

  Widget _buildOption(
      BuildContext context, SelectionOption<T> option, bool showCardLayout) {
    if (selectionType == SelectionType.checkbox) {
      final isChecked = selectedValues?.contains(option.value) ?? false;
      return _buildCheckboxRow(context, option, isChecked, showCardLayout);
    } else {
      final isSelected = selectedValue == option.value;
      return _buildRadioRow(context, option, isSelected, showCardLayout);
    }
  }

  Widget _buildCheckboxRow(
    BuildContext context,
    SelectionOption<T> option,
    bool isChecked,
    bool showCardLayout,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final canSelect = maxSelections == null ||
        (selectedValues?.length ?? 0) < maxSelections! ||
        isChecked;

    final checkbox = CheckboxEAE(
      value: isChecked,
      onChanged: onCheckboxChanged != null && canSelect
          ? (value) {
              final newValues = List<T>.from(selectedValues ?? []);
              if (value == true) {
                // Only add if not already at max
                if (maxSelections == null ||
                    newValues.length < maxSelections!) {
                  newValues.add(option.value);
                }
              } else {
                newValues.remove(option.value);
              }
              onCheckboxChanged!(newValues);
            }
          : null,
    );

    final text = Expanded(
      child: Text(
        option.label,
        style: textTheme.bodyLarge,
        textAlign: showCardLayout ? TextAlign.left : TextAlign.left,
      ),
    );

    final content = InkWell(
      onTap: onCheckboxChanged != null && canSelect
          ? () {
              final newValues = List<T>.from(selectedValues ?? []);
              if (isChecked) {
                newValues.remove(option.value);
              } else {
                // Only add if not already at max
                if (maxSelections == null ||
                    newValues.length < maxSelections!) {
                  newValues.add(option.value);
                }
              }
              onCheckboxChanged!(newValues);
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: showCardLayout
              ? [
                  text,
                  const SizedBox(width: 12),
                  checkbox,
                ]
              : [
                  checkbox,
                  const SizedBox(width: 12),
                  text,
                ],
        ),
      ),
    );

    // Apply opacity when max selections reached and item is not selected
    return Opacity(
      opacity: canSelect ? 1.0 : 0.4,
      child: content,
    );
  }

  Widget _buildRadioRow(
    BuildContext context,
    SelectionOption<T> option,
    bool isSelected,
    bool showCardLayout,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final radio = RadioButtonEAE<T>(
      value: option.value,
      groupValue: selectedValue,
      onChanged: onRadioChanged,
    );

    final text = Expanded(
      child: Text(
        option.label,
        style: textTheme.bodyLarge,
        textAlign: showCardLayout ? TextAlign.left : TextAlign.left,
      ),
    );

    return InkWell(
      onTap:
          onRadioChanged != null ? () => onRadioChanged!(option.value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: showCardLayout
              ? [
                  text,
                  const SizedBox(width: 12),
                  radio,
                ]
              : [
                  radio,
                  const SizedBox(width: 12),
                  text,
                ],
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    bool showCardLayout,
  ) {
    final textWidget = Text(
      actionLabel!,
      style: textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );

    return InkWell(
      onTap: onActionTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Empty space to align with checkbox/radio button (only when controls are on left)
            if (!showCardLayout) const SizedBox(width: 36),
            // With card: text takes all available space, chevron pushed to right
            // Without card: text stays compact, chevron stays close to text
            if (showCardLayout) Expanded(child: textWidget) else textWidget,
            if (showActionChevron) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
