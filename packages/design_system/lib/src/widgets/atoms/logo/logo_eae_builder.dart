import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'logo_eae.dart';

/// Builder for Logo component
class LogoBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['logo'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final brandStr = config.getProp<String>('brand') ?? 'match';
    final typeStr = config.getProp<String>('logoType') ?? 'onWhite';

    return LogoEAE(
      brand: parseBrand(brandStr),
      type: parseLogoType(typeStr),
      height: config.getProp<double>('height'),
    );
  }
}

