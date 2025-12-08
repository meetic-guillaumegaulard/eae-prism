import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

// Stateful wrapper to demonstrate interactivity
class _SelectableButtonDemo extends StatefulWidget {
  final String label;
  final ButtonEAESize size;
  final bool isFullWidth;

  const _SelectableButtonDemo({
    super.key,
    required this.label,
    this.size = ButtonEAESize.medium,
    this.isFullWidth = false,
  });

  @override
  State<_SelectableButtonDemo> createState() => _SelectableButtonDemoState();
}

class _SelectableButtonDemoState extends State<_SelectableButtonDemo> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SelectableButtonEAE(
      label: widget.label,
      isSelected: isSelected,
      size: widget.size,
      isFullWidth: widget.isFullWidth,
      onChanged: (value) {
        setState(() {
          isSelected = value;
        });
      },
    );
  }
}

Widget buildSelectableButton(BuildContext context) {
  return const Center(
    child: _SelectableButtonDemo(label: 'Toggle Me'),
  );
}

Widget buildSelectableButtonGroup(BuildContext context) {
  return const Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _SelectableButtonDemo(label: 'Option 1'),
        _SelectableButtonDemo(label: 'Option 2'),
        _SelectableButtonDemo(label: 'Option 3'),
      ],
    ),
  );
}

Widget buildSelectableButtonWidthBehavior(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fit Content (Default):',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _SelectableButtonDemo(label: 'Short'),
          SizedBox(height: 8),
          _SelectableButtonDemo(label: 'A bit longer label'),
          SizedBox(height: 32),
          Text('Full Width:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _SelectableButtonDemo(
            label: 'I take all available width',
            isFullWidth: true,
          ),
        ],
      ),
    ),
  );
}
