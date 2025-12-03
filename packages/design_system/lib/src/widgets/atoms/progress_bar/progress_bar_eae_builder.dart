import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'progress_bar_eae.dart';

/// Builder for ProgressBar component
class ProgressBarBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['progress_bar'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final value = config.getProp<int>('value') ??
        ((config.getProp<double>('progress') ?? 0.0) * 100).toInt();

    return ProgressBarEAE(
      min: config.getProp<int>('min') ?? 0,
      max: config.getProp<int>('max') ?? 100,
      value: value,
      showCounter: config.getProp<bool>('showPercentage') ??
          config.getProp<bool>('showCounter') ??
          true,
    );
  }
}

