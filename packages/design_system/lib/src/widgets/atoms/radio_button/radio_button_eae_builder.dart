import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import '../radio_button/radio_button_eae.dart';

/// Builder for RadioButton component
class RadioButtonBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['radio_button'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final radioValue = config.getProp<String>('value') ?? '';

    return FormFieldWidget<String>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<String>('defaultValue') ?? '',
      builder: (groupValue, onChanged) => RadioButtonEAE<String>(
        value: radioValue,
        groupValue: groupValue,
        onChanged: (v) => onChanged(v ?? ''),
      ),
    );
  }
}

