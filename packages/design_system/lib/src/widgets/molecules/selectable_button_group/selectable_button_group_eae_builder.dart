import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'selectable_button_group_eae.dart';

/// Builder for SelectableButtonGroup component
class SelectableButtonGroupBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['selectable_button_group'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final labels =
        config.getProp<List<dynamic>>('labels')?.cast<String>() ?? [];
    final options = labels
        .map((label) =>
            SelectableButtonOption<String>(label: label, value: label))
        .toList();

    return FormFieldWidget<String>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<String>('defaultValue') ?? '',
      builder: (selectedValue, onChanged) => SelectableButtonGroupEAE<String>(
        options: options,
        selectedValue: selectedValue,
        onChanged: onChanged,
        spacing: config.getProp<double>('spacing') ?? 8.0,
        size: parseButtonSize(config.getProp<String>('size')),
      ),
    );
  }
}

