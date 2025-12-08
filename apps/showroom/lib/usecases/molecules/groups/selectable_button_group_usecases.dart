import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

// Demo avec groupe vertical aligné à gauche
Widget buildSelectableButtonGroupVerticalStart(BuildContext context) {
  return const _SelectableButtonGroupDemoWithVariableText(
    axis: SelectableButtonGroupAxis.vertical,
    alignment: SelectableButtonGroupAlignment.start,
  );
}

// Demo avec groupe vertical aligné à droite
Widget buildSelectableButtonGroupVerticalEnd(BuildContext context) {
  return const _SelectableButtonGroupDemoWithVariableText(
    axis: SelectableButtonGroupAxis.vertical,
    alignment: SelectableButtonGroupAlignment.end,
  );
}

// Demo avec groupe vertical en pleine largeur
Widget buildSelectableButtonGroupVerticalStretch(BuildContext context) {
  return const _SelectableButtonGroupDemo(
    axis: SelectableButtonGroupAxis.vertical,
    alignment: SelectableButtonGroupAlignment.stretch,
  );
}

// Demo avec groupe horizontal
Widget buildSelectableButtonGroupHorizontal(BuildContext context) {
  return const _SelectableButtonGroupDemo(
    axis: SelectableButtonGroupAxis.horizontal,
    hasAdditionalOptions: true,
  );
}

// Demo avec options additionnelles
Widget buildSelectableButtonGroupWithAdditional(BuildContext context) {
  return const _SelectableButtonGroupDemo(
    axis: SelectableButtonGroupAxis.vertical,
    alignment: SelectableButtonGroupAlignment.stretch,
    hasAdditionalOptions: true,
  );
}

// Demo avec différentes tailles
Widget buildSelectableButtonGroupSizes(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Small:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _SelectableButtonGroupDemo(
            axis: SelectableButtonGroupAxis.vertical,
            alignment: SelectableButtonGroupAlignment.start,
            size: ButtonEAESize.small,
          ),
          SizedBox(height: 32),
          Text('Medium (Default):',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _SelectableButtonGroupDemo(
            axis: SelectableButtonGroupAxis.vertical,
            alignment: SelectableButtonGroupAlignment.start,
            size: ButtonEAESize.medium,
          ),
          SizedBox(height: 32),
          Text('Large:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _SelectableButtonGroupDemo(
            axis: SelectableButtonGroupAxis.vertical,
            alignment: SelectableButtonGroupAlignment.start,
            size: ButtonEAESize.large,
          ),
        ],
      ),
    ),
  );
}

// Demo avec icônes
Widget buildSelectableButtonGroupWithIcons(BuildContext context) {
  return const Center(
    child: _SelectableButtonGroupDemoWithIcons(),
  );
}

// Stateful wrapper pour démo interactive
class _SelectableButtonGroupDemo extends StatefulWidget {
  final SelectableButtonGroupAxis axis;
  final SelectableButtonGroupAlignment alignment;
  final ButtonEAESize size;
  final bool hasAdditionalOptions;

  const _SelectableButtonGroupDemo({
    super.key,
    this.axis = SelectableButtonGroupAxis.vertical,
    this.alignment = SelectableButtonGroupAlignment.stretch,
    this.size = ButtonEAESize.medium,
    this.hasAdditionalOptions = false,
  });

  @override
  State<_SelectableButtonGroupDemo> createState() =>
      _SelectableButtonGroupDemoState();
}

class _SelectableButtonGroupDemoState
    extends State<_SelectableButtonGroupDemo> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final mainOptions = [
      const SelectableButtonOption(
        label: 'Option 1',
        value: 'option1',
      ),
      const SelectableButtonOption(
        label: 'Option 2',
        value: 'option2',
      ),
      const SelectableButtonOption(
        label: 'Option 3',
        value: 'option3',
      ),
    ];

    final additionalOptions = widget.hasAdditionalOptions
        ? [
            const SelectableButtonOption(
              label: 'Option 4',
              value: 'option4',
            ),
            const SelectableButtonOption(
              label: 'Option 5',
              value: 'option5',
            ),
            const SelectableButtonOption(
              label: 'Option 6',
              value: 'option6',
            ),
          ]
        : null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableButtonGroupEAE<String>(
              options: mainOptions,
              additionalOptions: additionalOptions,
              selectedValue: selectedValue,
              axis: widget.axis,
              alignment: widget.alignment,
              size: widget.size,
              showMoreLabel: 'Afficher plus',
              showLessLabel: 'Afficher moins',
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
                // Log pour la démo
                debugPrint('Selected: $value');
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Selected: ${selectedValue ?? "None"}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Demo avec icônes
class _SelectableButtonGroupDemoWithIcons extends StatefulWidget {
  const _SelectableButtonGroupDemoWithIcons({super.key});

  @override
  State<_SelectableButtonGroupDemoWithIcons> createState() =>
      _SelectableButtonGroupDemoWithIconsState();
}

class _SelectableButtonGroupDemoWithIconsState
    extends State<_SelectableButtonGroupDemoWithIcons> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final options = [
      const SelectableButtonOption(
        label: 'Home',
        value: 'home',
        icon: Icons.home,
      ),
      const SelectableButtonOption(
        label: 'Profile',
        value: 'profile',
        icon: Icons.person,
      ),
      const SelectableButtonOption(
        label: 'Settings',
        value: 'settings',
        icon: Icons.settings,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableButtonGroupEAE<String>(
            options: options,
            selectedValue: selectedValue,
            axis: SelectableButtonGroupAxis.vertical,
            alignment: SelectableButtonGroupAlignment.stretch,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              debugPrint('Selected: $value');
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Selected: ${selectedValue ?? "None"}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Demo avec texte de longueur variable pour tester l'alignement
class _SelectableButtonGroupDemoWithVariableText extends StatefulWidget {
  final SelectableButtonGroupAxis axis;
  final SelectableButtonGroupAlignment alignment;

  const _SelectableButtonGroupDemoWithVariableText({
    super.key,
    this.axis = SelectableButtonGroupAxis.vertical,
    this.alignment = SelectableButtonGroupAlignment.stretch,
  });

  @override
  State<_SelectableButtonGroupDemoWithVariableText> createState() =>
      _SelectableButtonGroupDemoWithVariableTextState();
}

class _SelectableButtonGroupDemoWithVariableTextState
    extends State<_SelectableButtonGroupDemoWithVariableText> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final mainOptions = [
      const SelectableButtonOption(
        label: 'Court',
        value: 'short',
      ),
      const SelectableButtonOption(
        label: 'Un texte plus long',
        value: 'medium',
      ),
      const SelectableButtonOption(
        label: 'Ceci est un texte très long pour tester',
        value: 'long',
      ),
      const SelectableButtonOption(
        label: 'X',
        value: 'veryshort',
      ),
      const SelectableButtonOption(
        label: 'Option moyenne',
        value: 'mediumtext',
      ),
    ];

    final additionalOptions = [
      const SelectableButtonOption(
        label: 'Autre option',
        value: 'extra1',
      ),
      const SelectableButtonOption(
        label: 'Un label additionnel avec beaucoup de texte',
        value: 'extra2',
      ),
      const SelectableButtonOption(
        label: 'Plus',
        value: 'extra3',
      ),
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableButtonGroupEAE<String>(
              options: mainOptions,
              additionalOptions: additionalOptions,
              selectedValue: selectedValue,
              axis: widget.axis,
              alignment: widget.alignment,
              showMoreLabel: 'Afficher plus d\'options',
              showLessLabel: 'Afficher moins',
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
                debugPrint('Selected: $value');
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Selected: ${selectedValue ?? "None"}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
