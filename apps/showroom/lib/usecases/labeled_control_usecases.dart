import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class _LabeledControlCheckboxDemo extends StatefulWidget {
  @override
  State<_LabeledControlCheckboxDemo> createState() =>
      _LabeledControlCheckboxDemoState();
}

class _LabeledControlCheckboxDemoState
    extends State<_LabeledControlCheckboxDemo> {
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LabeledControlEAE(
          htmlLabel:
              'J\'accepte les <a href="https://example.com/terms">Conditions d\'utilisation</a>',
          value: isAccepted,
          onChanged: (value) {
            setState(() {
              isAccepted = value ?? false;
            });
          },
          controlType: ControlType.checkbox,
          controlPosition: ControlPosition.left,
        ),
      ),
    );
  }
}

class _LabeledControlToggleDemo extends StatefulWidget {
  @override
  State<_LabeledControlToggleDemo> createState() =>
      _LabeledControlToggleDemoState();
}

class _LabeledControlToggleDemoState extends State<_LabeledControlToggleDemo> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LabeledControlEAE(
          htmlLabel:
              'Activer les <a href="https://example.com/notifications">notifications</a>',
          value: isEnabled,
          onChanged: (value) {
            setState(() {
              isEnabled = value ?? false;
            });
          },
          controlType: ControlType.toggle,
          controlPosition: ControlPosition.left,
        ),
      ),
    );
  }
}

class _LabeledControlRightDemo extends StatefulWidget {
  @override
  State<_LabeledControlRightDemo> createState() =>
      _LabeledControlRightDemoState();
}

class _LabeledControlRightDemoState extends State<_LabeledControlRightDemo> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LabeledControlEAE(
          htmlLabel:
              'Recevoir des <a href="https://example.com/offers">offres promotionnelles</a>',
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          controlType: ControlType.checkbox,
          controlPosition: ControlPosition.right,
        ),
      ),
    );
  }
}

class _LabeledControlMeeticDemo extends StatefulWidget {
  @override
  State<_LabeledControlMeeticDemo> createState() =>
      _LabeledControlMeeticDemoState();
}

class _LabeledControlMeeticDemoState extends State<_LabeledControlMeeticDemo> {
  bool isConsented = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LabeledControlEAE(
          htmlLabel:
              'Je consens au traitement de mes <a href="https://www.meetic.fr/pages/misc/privacy">données sensibles</a> et à l\'utilisation de <a href="https://www.meetic.fr/pages/misc/safety">Filtres de messages sécurisés</a> par Meetic à des fins de prestation de services.',
          value: isConsented,
          onChanged: (value) {
            setState(() {
              isConsented = value ?? false;
            });
          },
          controlType: ControlType.checkbox,
          controlPosition: ControlPosition.left,
        ),
      ),
    );
  }
}

class _LabeledControlNotExpandedDemo extends StatefulWidget {
  @override
  State<_LabeledControlNotExpandedDemo> createState() =>
      _LabeledControlNotExpandedDemoState();
}

class _LabeledControlNotExpandedDemoState
    extends State<_LabeledControlNotExpandedDemo> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LabeledControlEAE(
          htmlLabel: 'Texte court',
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          controlType: ControlType.checkbox,
          controlPosition: ControlPosition.left,
          expanded: false,
        ),
      ),
    );
  }
}

class _LabeledControlDisabledDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: LabeledControlEAE(
          htmlLabel:
              'Cette option est <a href="https://example.com/info">désactivée</a>',
          value: false,
          onChanged: null,
          controlType: ControlType.checkbox,
          controlPosition: ControlPosition.left,
        ),
      ),
    );
  }
}

Widget buildLabeledControlCheckbox(BuildContext context) {
  return _LabeledControlCheckboxDemo();
}

Widget buildLabeledControlToggle(BuildContext context) {
  return _LabeledControlToggleDemo();
}

Widget buildLabeledControlRight(BuildContext context) {
  return _LabeledControlRightDemo();
}

Widget buildLabeledControlMeetic(BuildContext context) {
  return _LabeledControlMeeticDemo();
}

Widget buildLabeledControlNotExpanded(BuildContext context) {
  return _LabeledControlNotExpandedDemo();
}

Widget buildLabeledControlDisabled(BuildContext context) {
  return _LabeledControlDisabledDemo();
}

