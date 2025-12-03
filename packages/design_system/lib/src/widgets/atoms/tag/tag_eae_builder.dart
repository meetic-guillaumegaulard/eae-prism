import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import '../tag/tag_eae.dart';

/// Builder for Tag component
class TagBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['tag'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');

    if (field != null) {
      return FormFieldWidget<bool>(
        field: field,
        formState: context.formState,
        defaultValue: config.getProp<bool>('defaultValue') ?? false,
        builder: (isSelected, onChanged) => TagEAE(
          label: config.getProp<String>('label') ?? 'Tag',
          isSelected: isSelected,
          onSelectedChanged: onChanged,
          size: parseTagSize(config.getProp<String>('size')),
        ),
      );
    }

    return TagEAE(
      label: config.getProp<String>('label') ?? 'Tag',
      size: parseTagSize(config.getProp<String>('size')),
    );
  }
}

