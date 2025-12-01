import 'package:flutter/material.dart';
import '../atoms/selectable_button_eae.dart';
import '../atoms/button_eae.dart';

/// Represents an option in the selectable button group
class SelectableButtonOption<T> {
  final String label;
  final T value;
  final IconData? icon;

  const SelectableButtonOption({
    required this.label,
    required this.value,
    this.icon,
  });
}

/// Enum to define the layout direction
enum SelectableButtonGroupAxis {
  vertical,
  horizontal,
}

/// Enum to define alignment for vertical layout
enum SelectableButtonGroupAlignment {
  start,
  end,
  stretch,
}

/// A molecule component that manages a group of selectable buttons
class SelectableButtonGroupEAE<T> extends StatefulWidget {
  /// List of main options
  final List<SelectableButtonOption<T>> options;

  /// List of additional options (shown when expanded)
  final List<SelectableButtonOption<T>>? additionalOptions;

  /// Currently selected value
  final T? selectedValue;

  /// Callback when a button is selected
  final ValueChanged<T>? onChanged;

  /// Layout direction (vertical or horizontal)
  final SelectableButtonGroupAxis axis;

  /// Alignment for vertical layout
  final SelectableButtonGroupAlignment alignment;

  /// Size of the buttons
  final ButtonEAESize size;

  /// Label for "show more" button
  final String showMoreLabel;

  /// Label for "show less" button
  final String showLessLabel;

  /// Spacing between buttons
  final double spacing;

  const SelectableButtonGroupEAE({
    Key? key,
    required this.options,
    this.additionalOptions,
    this.selectedValue,
    this.onChanged,
    this.axis = SelectableButtonGroupAxis.vertical,
    this.alignment = SelectableButtonGroupAlignment.stretch,
    this.size = ButtonEAESize.medium,
    this.showMoreLabel = 'Show more',
    this.showLessLabel = 'Show less',
    this.spacing = 8.0,
  }) : super(key: key);

  @override
  State<SelectableButtonGroupEAE<T>> createState() =>
      _SelectableButtonGroupEAEState<T>();
}

class _SelectableButtonGroupEAEState<T>
    extends State<SelectableButtonGroupEAE<T>> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasAdditionalOptions = widget.additionalOptions != null &&
        widget.additionalOptions!.isNotEmpty;

    // Determine which options to display
    final List<SelectableButtonOption<T>> displayedOptions = [
      ...widget.options,
      if (_isExpanded && hasAdditionalOptions) ...widget.additionalOptions!,
    ];

    // Build the list of buttons
    final List<Widget> buttons = displayedOptions.map((option) {
      final isSelected = widget.selectedValue == option.value;
      return _buildButton(option, isSelected);
    }).toList();

    // Build the layout based on axis
    if (widget.axis == SelectableButtonGroupAxis.vertical) {
      // Add show more/less button if there are additional options
      if (hasAdditionalOptions) {
        buttons.add(_buildToggleButton());
      }
      return _buildVerticalLayout(buttons);
    } else {
      return _buildHorizontalLayout(
          buttons, hasAdditionalOptions ? _buildToggleButton() : null);
    }
  }

  Widget _buildButton(SelectableButtonOption<T> option, bool isSelected) {
    final bool isFullWidth =
        widget.axis == SelectableButtonGroupAxis.vertical &&
            widget.alignment == SelectableButtonGroupAlignment.stretch;

    return SelectableButtonEAE(
      label: option.label,
      icon: option.icon,
      isSelected: isSelected,
      size: widget.size,
      isFullWidth: isFullWidth,
      onChanged: widget.onChanged != null
          ? (_) => widget.onChanged!(option.value)
          : null,
    );
  }

  Widget _buildToggleButton() {
    final bool isFullWidth =
        widget.axis == SelectableButtonGroupAxis.vertical &&
            widget.alignment == SelectableButtonGroupAlignment.stretch;

    return TextButton(
      onPressed: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      style: TextButton.styleFrom(
        alignment: widget.alignment == SelectableButtonGroupAlignment.start
            ? Alignment.centerLeft
            : widget.alignment == SelectableButtonGroupAlignment.end
                ? Alignment.centerRight
                : Alignment.center,
        minimumSize: isFullWidth ? const Size(double.infinity, 36) : null,
      ),
      child: Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment:
            widget.alignment == SelectableButtonGroupAlignment.start
                ? MainAxisAlignment.start
                : widget.alignment == SelectableButtonGroupAlignment.end
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
        children: [
          Text(_isExpanded ? widget.showLessLabel : widget.showMoreLabel),
          const SizedBox(width: 4),
          Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalLayout(List<Widget> buttons) {
    CrossAxisAlignment crossAxisAlignment;

    switch (widget.alignment) {
      case SelectableButtonGroupAlignment.start:
        crossAxisAlignment = CrossAxisAlignment.start;
        break;
      case SelectableButtonGroupAlignment.end:
        crossAxisAlignment = CrossAxisAlignment.end;
        break;
      case SelectableButtonGroupAlignment.stretch:
        crossAxisAlignment = CrossAxisAlignment.stretch;
        break;
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: buttons
          .expand((button) => [button, SizedBox(height: widget.spacing)])
          .toList()
        ..removeLast(), // Remove the last spacing
    );
  }

  Widget _buildHorizontalLayout(List<Widget> buttons, Widget? toggleButton) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          children: buttons,
        ),
        if (toggleButton != null) ...[
          SizedBox(height: widget.spacing),
          toggleButton,
        ],
      ],
    );
  }
}
