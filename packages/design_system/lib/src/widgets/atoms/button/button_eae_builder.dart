import 'package:flutter/material.dart';
import '../../pages/dynamic_json/component_config.dart';
import '../../pages/dynamic_json/shared/shared.dart';
import '../button/button_eae.dart';

/// Builder for Button component
class ButtonBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => ['button'];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    final apiEndpoint = config.getProp<String>('apiEndpoint');
    final exitDestination = config.getProp<String>('exit');

    VoidCallback? callback;

    // Priority: apiEndpoint > exit
    if (apiEndpoint != null && context.onApiAction != null) {
      callback = () => context.onApiAction!(apiEndpoint);
    } else if (exitDestination != null && context.onExit != null) {
      callback = () => context.onExit!(exitDestination, context.formState.nestedValues);
    }

    return ButtonEAE(
      label: config.getProp<String>('label') ?? 'Button',
      onPressed: callback,
      variant: parseButtonVariant(config.getProp<String>('variant')),
      size: parseButtonSize(config.getProp<String>('size')),
      isLoading: config.getProp<bool>('isLoading') ?? false,
      isFullWidth: config.getProp<bool>('isFullWidth') ?? false,
      icon: parseIconData(config.getProp<String>('icon')),
    );
  }
}

