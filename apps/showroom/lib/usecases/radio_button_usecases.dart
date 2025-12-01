import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

enum RadioOption { option1, option2, option3 }

class _RadioButtonDemo extends StatefulWidget {
  @override
  State<_RadioButtonDemo> createState() => _RadioButtonDemoState();
}

class _RadioButtonDemoState extends State<_RadioButtonDemo> {
  RadioOption? _selectedOption = RadioOption.option1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioButtonEAE<RadioOption>(
                value: RadioOption.option1,
                groupValue: _selectedOption,
                onChanged: (value) => setState(() => _selectedOption = value),
              ),
              const SizedBox(width: 12),
              const Text('Option 1'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioButtonEAE<RadioOption>(
                value: RadioOption.option2,
                groupValue: _selectedOption,
                onChanged: (value) => setState(() => _selectedOption = value),
              ),
              const SizedBox(width: 12),
              const Text('Option 2'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioButtonEAE<RadioOption>(
                value: RadioOption.option3,
                groupValue: _selectedOption,
                onChanged: (value) => setState(() => _selectedOption = value),
              ),
              const SizedBox(width: 12),
              const Text('Option 3'),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildRadioButton(BuildContext context) {
  return _RadioButtonDemo();
}

