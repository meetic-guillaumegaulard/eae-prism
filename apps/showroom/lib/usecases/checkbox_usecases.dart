import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class _CheckboxDemo extends StatefulWidget {
  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxEAE(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
          ),
          const SizedBox(width: 12),
          const Text('Accept Terms'),
        ],
      ),
    );
  }
}

Widget buildCheckbox(BuildContext context) {
  return _CheckboxDemo();
}

