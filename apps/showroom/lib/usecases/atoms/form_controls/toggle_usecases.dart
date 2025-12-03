import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class _ToggleDemo extends StatefulWidget {
  @override
  State<_ToggleDemo> createState() => _ToggleDemoState();
}

class _ToggleDemoState extends State<_ToggleDemo> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleEAE(
            value: isEnabled,
            onChanged: (value) {
              setState(() {
                isEnabled = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            isEnabled ? 'Activé' : 'Désactivé',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _ToggleStatesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Off: '),
              const SizedBox(width: 8),
              ToggleEAE(
                value: false,
                onChanged: (_) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('On: '),
              const SizedBox(width: 8),
              ToggleEAE(
                value: true,
                onChanged: (_) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Disabled Off: '),
              const SizedBox(width: 8),
              ToggleEAE(
                value: false,
                onChanged: null,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Disabled On: '),
              const SizedBox(width: 8),
              ToggleEAE(
                value: true,
                onChanged: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildToggle(BuildContext context) {
  return _ToggleDemo();
}

Widget buildToggleStates(BuildContext context) {
  return _ToggleStatesDemo();
}

