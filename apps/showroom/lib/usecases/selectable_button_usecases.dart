import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

// Stateful wrapper to demonstrate interactivity
class _SelectableButtonDemo extends StatefulWidget {
  final String label;
  final ButtonEAESize size;

  const _SelectableButtonDemo({
    Key? key,
    required this.label,
    this.size = ButtonEAESize.medium,
  }) : super(key: key);

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
  return Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: const [
        _SelectableButtonDemo(label: 'Option 1'),
        _SelectableButtonDemo(label: 'Option 2'),
        _SelectableButtonDemo(label: 'Option 3'),
      ],
    ),
  );
}

