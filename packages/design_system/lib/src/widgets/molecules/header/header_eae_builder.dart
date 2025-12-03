import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'header_eae.dart';

/// Builder for Header component
class HeaderBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['header'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final iconName = config.getProp<String>('icon') ?? 'star';
    final icon = parseIconData(iconName) ?? Icons.star;
    final exitDestination = config.getProp<String>('exit');

    VoidCallback? onBack;
    if (exitDestination != null && context.onExit != null) {
      onBack = () => context.onExit!(exitDestination, context.formState.nestedValues);
    }

    return HeaderEAE(
      icon: icon,
      text: config.getProp<String>('text') ?? '',
      onBack: onBack,
      showBackgroundIcon: config.getProp<bool>('showBackgroundIcon') ?? true,
      backgroundIconSize: config.getProp<double>('backgroundIconSize') ?? 200.0,
      backgroundIconOpacity:
          config.getProp<double>('backgroundIconOpacity') ?? 0.15,
    );
  }
}

