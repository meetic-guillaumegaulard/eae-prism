import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'slider_eae.dart';

/// Builder for Slider component (single value)
class SliderBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['slider'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final minValue = config.getProp<int>('minValue') ?? 0;
    final maxValue = config.getProp<int>('maxValue') ?? 100;

    return FormFieldWidget<int>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<int>('defaultValue') ?? minValue,
      builder: (value, onChanged) => SliderEAE.single(
        minValue: minValue,
        maxValue: maxValue,
        initialValue: value,
        onChanged: onChanged,
        label: config.getProp<String>('label'),
        showLabels: config.getProp<bool>('showLabels') ?? true,
        showMinMaxLabels: config.getProp<bool>('showMinMaxLabels') ?? true,
      ),
    );
  }
}

/// Builder for SliderRange component (range values)
class SliderRangeBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['slider_range'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final minValue = config.getProp<int>('minValue') ?? 0;
    final maxValue = config.getProp<int>('maxValue') ?? 100;

    // Parse default range values
    final defaultStart = config.getProp<int>('defaultStart') ?? minValue;
    final defaultEnd = config.getProp<int>('defaultEnd') ?? maxValue;

    return FormFieldWidget<Map<String, int>>(
      field: field,
      formState: context.formState,
      defaultValue: {'start': defaultStart, 'end': defaultEnd},
      builder: (value, onChanged) => SliderEAE.range(
        minValue: minValue,
        maxValue: maxValue,
        initialRange: RangeValues(
          (value['start'] ?? defaultStart).toDouble(),
          (value['end'] ?? defaultEnd).toDouble(),
        ),
        onRangeChanged: (range) => onChanged({
          'start': range.start.round(),
          'end': range.end.round(),
        }),
        label: config.getProp<String>('label'),
        showLabels: config.getProp<bool>('showLabels') ?? true,
        showMinMaxLabels: config.getProp<bool>('showMinMaxLabels') ?? true,
      ),
    );
  }
}

