import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'selectable_tag_group_eae.dart';

/// Builder for SelectableTagGroup component
class SelectableTagGroupBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['selectable_tag_group'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final labels =
        config.getProp<List<dynamic>>('labels')?.cast<String>() ?? [];

    // Convert labels to tag options
    final options = labels
        .map((label) => TagOption<String>(label: label, value: label))
        .toList();

    // Create a single group
    final group = TagGroup<String>(
      title: config.getProp<String>('title') ?? '',
      options: options,
    );

    final defaultValues =
        config.getProp<List<dynamic>>('defaultValue')?.cast<String>() ?? [];

    return FormFieldWidget<List<String>>(
      field: field,
      formState: context.formState,
      defaultValue: defaultValues,
      builder: (selectedValues, onChanged) => SelectableTagGroupEAE<String>(
        groups: [group],
        initialSelectedValues: selectedValues,
        onSelectionChanged: onChanged,
        tagSize: parseTagSize(config.getProp<String>('tagSize')),
        tagSpacing: config.getProp<double>('tagSpacing') ?? 8.0,
      ),
    );
  }
}

