import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'labeled_control_eae.dart';

/// Builder for LabeledControl component
class LabeledControlBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['labeled_control'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final controlTypeStr = config.getProp<String>('controlType');
    final controlType =
        controlTypeStr == 'toggle' ? ControlType.toggle : ControlType.checkbox;

    return FormFieldWidget<bool>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (value, onChanged) => LabeledControlEAE(
        htmlLabel: config.getProp<String>('htmlLabel') ??
            config.getProp<String>('label') ??
            '',
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        controlType: controlType,
        expanded: config.getProp<bool>('expanded') ?? true,
      ),
    );
  }
}

