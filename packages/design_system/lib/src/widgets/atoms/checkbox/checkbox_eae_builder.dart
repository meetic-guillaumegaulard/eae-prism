import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import '../checkbox/checkbox_eae.dart';

/// Builder for Checkbox component
class CheckboxBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['checkbox'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');

    return FormFieldWidget<bool>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (value, onChanged) => CheckboxEAE(
        value: value,
        onChanged: (v) => onChanged(v ?? false),
      ),
    );
  }
}

