import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import '../linked_text/linked_text_eae.dart';

/// Builder for LinkedText component
class LinkedTextBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['linked_text'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    return LinkedTextEAE(
      htmlText: config.getProp<String>('htmlText') ??
          config.getProp<String>('text') ??
          '',
      textAlign: parseTextAlign(config.getProp<String>('textAlign')) ??
          TextAlign.start,
    );
  }
}
