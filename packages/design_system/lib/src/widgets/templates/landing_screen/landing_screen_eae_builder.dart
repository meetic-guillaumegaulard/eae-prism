import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import 'landing_screen_eae.dart';

/// Builder for LandingScreen template
class LandingScreenBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['landing_screen'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final brandStr = config.getProp<String>('brand') ?? 'match';
    final mobileLogoTypeStr =
        config.getProp<String>('mobileLogoType') ?? 'onDark';
    final desktopLogoTypeStr =
        config.getProp<String>('desktopLogoType') ?? 'small';
    final topBarButtonExit = config.getProp<String>('topBarButtonExit');

    // Build content from children
    Widget content = const SizedBox();
    if (config.children != null && config.children!.isNotEmpty) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: context.buildChildren(config.children),
      );
    }

    // Build bottom bar from bottomBar child
    Widget? bottomBar;
    final bottomBarConfig = config.getProp<Map<String, dynamic>>('bottomBar');
    if (bottomBarConfig != null) {
      bottomBar = context.buildChild(ComponentConfig.fromJson(bottomBarConfig));
    }

    return LandingScreenEAE(
      config: LandingScreenConfig(
        brand: parseBrand(brandStr),
        mobileLogoType: parseLogoType(mobileLogoTypeStr),
        desktopLogoType: parseLogoType(desktopLogoTypeStr),
        mobileLogoHeight: config.getProp<double>('mobileLogoHeight'),
        desktopLogoHeight: config.getProp<double>('desktopLogoHeight'),
        topBarButtonText: config.getProp<String>('topBarButtonText'),
        onTopBarButtonPressed: topBarButtonExit != null && context.onExit != null
            ? () => context.onExit!(topBarButtonExit, context.formState.nestedValues)
            : null,
      ),
      content: content,
      bottomBar: bottomBar,
    );
  }
}

