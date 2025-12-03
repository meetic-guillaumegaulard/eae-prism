import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'icon_eae.dart';

/// Builder for Icon component
class IconBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['icon'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final iconName = config.getProp<String>('icon') ?? 'star';
    final icon = parseIconData(iconName) ?? Icons.star;

    return IconEAE(
      icon,
      sizeEnum: parseIconSize(config.getProp<String>('size')),
      color: config.getProp<Color>('color'),
      semanticLabel: config.getProp<String>('semanticLabel'),
    );
  }
}

