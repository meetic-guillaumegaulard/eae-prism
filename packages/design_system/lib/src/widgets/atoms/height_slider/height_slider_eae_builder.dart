import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'height_slider_eae.dart';

/// Builder for HeightSlider component
class HeightSliderBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['height_slider'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final field = config.getProp<String>('field');
    final minValue = config.getProp<int>('minValue') ?? 140;
    final maxValue = config.getProp<int>('maxValue') ?? 220;

    return FormFieldWidget<int>(
      field: field,
      formState: context.formState,
      defaultValue: config.getProp<int>('defaultValue') ?? 170,
      builder: (value, onChanged) => HeightSliderEAE(
        minValue: minValue,
        maxValue: maxValue,
        initialValue: value,
        onChanged: onChanged,
        label: config.getProp<String>('label'),
        showCurrentValue: config.getProp<bool>('showCurrentValue') ?? true,
      ),
    );
  }
}

