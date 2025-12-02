import 'package:flutter/material.dart';
import '../atoms/tag_eae.dart';

/// Represents a group of selectable tags
class TagGroup<T> {
  final String title;
  final List<TagOption<T>> options;

  const TagGroup({
    required this.title,
    required this.options,
  });
}

/// Represents a single tag option
class TagOption<T> {
  final String label;
  final T value;

  const TagOption({
    required this.label,
    required this.value,
  });
}

/// A molecule component that manages groups of selectable tags
/// Displays multiple groups with titles and allows selecting tags across all groups
class SelectableTagGroupEAE<T> extends StatefulWidget {
  /// List of tag groups to display
  final List<TagGroup<T>> groups;

  /// Initially selected values
  final List<T> initialSelectedValues;

  /// Callback when the selection changes
  final ValueChanged<List<T>> onSelectionChanged;

  /// Maximum number of selections allowed (null = unlimited)
  final int? maxSelections;

  /// Size of the tags
  final TagEAESize tagSize;

  /// Variant of the tags
  final TagEAEVariant tagVariant;

  /// Spacing between tags
  final double tagSpacing;

  /// Spacing between groups
  final double groupSpacing;

  /// Spacing between title and tags
  final double titleSpacing;

  /// Title text style
  final TextStyle? titleStyle;

  /// Custom background color for selected tags
  final Color? selectedBackgroundColor;

  /// Custom foreground color for selected tags
  final Color? selectedForegroundColor;

  /// Custom border color for selected tags
  final Color? selectedBorderColor;

  /// Custom background color for unselected tags
  final Color? unselectedBackgroundColor;

  /// Custom foreground color for unselected tags
  final Color? unselectedForegroundColor;

  /// Custom border color for unselected tags
  final Color? unselectedBorderColor;

  const SelectableTagGroupEAE({
    Key? key,
    required this.groups,
    required this.onSelectionChanged,
    this.initialSelectedValues = const [],
    this.maxSelections,
    this.tagSize = TagEAESize.medium,
    this.tagVariant = TagEAEVariant.filled,
    this.tagSpacing = 8.0,
    this.groupSpacing = 24.0,
    this.titleSpacing = 12.0,
    this.titleStyle,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedBorderColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.unselectedBorderColor,
  }) : super(key: key);

  @override
  State<SelectableTagGroupEAE<T>> createState() =>
      _SelectableTagGroupEAEState<T>();
}

class _SelectableTagGroupEAEState<T> extends State<SelectableTagGroupEAE<T>> {
  late List<T> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List<T>.from(widget.initialSelectedValues);
  }

  @override
  void didUpdateWidget(SelectableTagGroupEAE<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected values if initial values changed
    if (oldWidget.initialSelectedValues != widget.initialSelectedValues) {
      _selectedValues = List<T>.from(widget.initialSelectedValues);
    }
  }

  void _handleTagTap(T value, bool isSelected) {
    if (isSelected) {
      // Deselect
      setState(() {
        _selectedValues.remove(value);
      });
      widget.onSelectionChanged(_selectedValues);
    } else {
      // Select if not at max
      if (widget.maxSelections == null ||
          _selectedValues.length < widget.maxSelections!) {
        setState(() {
          _selectedValues.add(value);
        });
        widget.onSelectionChanged(_selectedValues);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final effectiveTitleStyle = widget.titleStyle ??
        textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );

    final isMaxReached = widget.maxSelections != null &&
        _selectedValues.length >= widget.maxSelections!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.groups.asMap().entries.map((groupEntry) {
        final groupIndex = groupEntry.key;
        final group = groupEntry.value;
        final isLastGroup = groupIndex == widget.groups.length - 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group title
            if (group.title.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(bottom: widget.titleSpacing),
                child: Text(
                  group.title,
                  style: effectiveTitleStyle,
                ),
              ),

            // Tags in this group
            Wrap(
              spacing: widget.tagSpacing,
              runSpacing: widget.tagSpacing,
              children: group.options.map((option) {
                final isSelected = _selectedValues.contains(option.value);
                final isDisabled = !isSelected && isMaxReached;

                return Opacity(
                  opacity: isDisabled ? 0.5 : 1.0,
                  child: TagEAE(
                    label: option.label,
                    size: widget.tagSize,
                    variant: widget.tagVariant,
                    isSelected: isSelected,
                    // Si désactivé, on passe null pour empêcher l'interaction
                    onSelectedChanged: isDisabled
                        ? null
                        : (_) => _handleTagTap(option.value, isSelected),
                    selectedBackgroundColor: widget.selectedBackgroundColor,
                    selectedForegroundColor: widget.selectedForegroundColor,
                    selectedBorderColor: widget.selectedBorderColor,
                    backgroundColor: widget.unselectedBackgroundColor,
                    foregroundColor: widget.unselectedForegroundColor,
                    borderColor: widget.unselectedBorderColor,
                  ),
                );
              }).toList(),
            ),

            // Spacing between groups
            if (!isLastGroup) SizedBox(height: widget.groupSpacing),
          ],
        );
      }).toList(),
    );
  }
}

