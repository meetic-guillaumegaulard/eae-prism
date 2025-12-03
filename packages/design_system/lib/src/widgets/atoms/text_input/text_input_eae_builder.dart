import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'text_input_eae.dart';

/// Builder for TextInput component
class TextInputBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['text_input'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');

    return FormFieldWidget<String>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<String>('defaultValue') ?? '',
      builder: (value, onChanged) => TextInputEAE(
        label: config.getProp<String>('label'),
        hintText: config.getProp<String>('hintText'),
        obscureText: config.getProp<bool>('obscureText') ?? false,
        enabled: config.getProp<bool>('enabled') ?? true,
        errorText: config.getProp<String>('errorText'),
        onChanged: onChanged,
      ),
    );
  }
}

