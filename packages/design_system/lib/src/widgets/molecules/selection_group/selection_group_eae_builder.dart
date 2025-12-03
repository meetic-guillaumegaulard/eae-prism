import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'selection_group_eae.dart';

/// Builder for SelectionGroup component
class SelectionGroupBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['selection_group'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final typeStr = config.getProp<String>('selectionType') ?? 'checkbox';
    final selectionType =
        typeStr == 'radio' ? SelectionType.radio : SelectionType.checkbox;

    // Parse options from labels array
    final labels =
        config.getProp<List<dynamic>>('labels')?.cast<String>() ?? [];
    final options = labels
        .map((label) => SelectionOption<String>(label: label, value: label))
        .toList();

    if (selectionType == SelectionType.radio) {
      return FormFieldWidget<String>(
        field: field,
        formState: context.formState,
        defaultValue: config.getProp<String>('defaultValue') ?? '',
        builder: (selectedValue, onChanged) => SelectionGroupEAE<String>(
          options: options,
          selectionType: selectionType,
          selectedValue: selectedValue,
          onRadioChanged: (value) => onChanged(value ?? ''),
          spacing: config.getProp<double>('spacing') ?? 8.0,
        ),
      );
    } else {
      final defaultValues =
          config.getProp<List<dynamic>>('defaultValue')?.cast<String>() ?? [];

      return FormFieldWidget<List<String>>(
        field: field,
        formState: context.formState,
        defaultValue: defaultValues,
        builder: (selectedValues, onChanged) => SelectionGroupEAE<String>(
          options: options,
          selectionType: selectionType,
          selectedValues: selectedValues,
          onCheckboxChanged: onChanged,
          spacing: config.getProp<double>('spacing') ?? 8.0,
        ),
      );
    }
  }
}

