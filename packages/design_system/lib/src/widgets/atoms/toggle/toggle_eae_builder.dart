import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import '../toggle/toggle_eae.dart';

/// Builder for Toggle component
class ToggleBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['toggle'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');

    return FormFieldWidget<bool>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (value, onChanged) => ToggleEAE(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

