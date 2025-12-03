import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'text_eae.dart';

/// Builder for Text component
class TextBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['text'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    return TextEAE(
      config.getProp<String>('text') ?? '',
      type: parseTextType(config.getProp<String>('type')),
      color: config.getProp<Color>('color'),
      fontWeight: parseFontWeight(config.getProp<String>('fontWeight')),
      textAlign: parseTextAlign(config.getProp<String>('textAlign')),
      maxLines: config.getProp<int>('maxLines'),
      overflow: parseTextOverflow(config.getProp<String>('overflow')),
    );
  }
}

