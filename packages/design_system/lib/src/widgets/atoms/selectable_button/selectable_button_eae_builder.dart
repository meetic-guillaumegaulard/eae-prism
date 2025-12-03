import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'selectable_button_eae.dart';

/// Builder for SelectableButton component
class SelectableButtonBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['selectable_button'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');

    return FormFieldWidget<bool>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (isSelected, onChanged) => SelectableButtonEAE(
        label: config.getProp<String>('label') ?? 'Button',
        isSelected: isSelected,
        onChanged: onChanged,
        size: parseButtonSize(config.getProp<String>('size')),
        isFullWidth: config.getProp<bool>('isFullWidth') ?? false,
      ),
    );
  }
}

