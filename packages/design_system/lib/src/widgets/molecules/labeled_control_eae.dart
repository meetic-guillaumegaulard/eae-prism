import 'package:flutter/material.dart';
import '../atoms/checkbox_eae.dart';
import '../atoms/toggle_eae.dart';
import '../atoms/linked_text_eae.dart';
import '../../theme/brand_theme_extensions.dart';

enum ControlType { toggle, checkbox }
enum ControlPosition { left, right }

class LabeledControlEAE extends StatelessWidget {
  final String htmlLabel;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final ControlType controlType;
  final ControlPosition controlPosition;
  final bool expanded;
  final TextAlign textAlign;

  const LabeledControlEAE({
    super.key,
    required this.htmlLabel,
    required this.value,
    required this.onChanged,
    this.controlType = ControlType.checkbox,
    this.controlPosition = ControlPosition.left,
    this.expanded = true,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labeledControlTheme = theme.extension<BrandLabeledControlTheme>();
    
    final control = _buildControl();
    final label = _buildLabel(labeledControlTheme);

    final content = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: controlPosition == ControlPosition.left
          ? [
              control,
              const SizedBox(width: 12),
              Expanded(child: label),
            ]
          : [
              Expanded(child: label),
              const SizedBox(width: 12),
              control,
            ],
    );

    return expanded ? content : IntrinsicWidth(child: content);
  }

  Widget _buildControl() {
    switch (controlType) {
      case ControlType.toggle:
        return ToggleEAE(
          value: value,
          onChanged: onChanged,
        );
      case ControlType.checkbox:
        return CheckboxEAE(
          value: value,
          onChanged: onChanged,
        );
    }
  }

  Widget _buildLabel(BrandLabeledControlTheme? theme) {
    // Obtenir le padding approprié selon le type de contrôle
    final paddingTop = controlType == ControlType.checkbox
        ? (theme?.checkboxLabelPaddingTop ?? 0.0)
        : (theme?.toggleLabelPaddingTop ?? 0.0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged != null
          ? () {
              // Appeler onChanged avec la valeur inversée
              onChanged!(!value);
            }
          : null,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: LinkedTextEAE(
          htmlText: htmlLabel,
          textAlign: textAlign,
        ),
      ),
    );
  }
}

