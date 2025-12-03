import 'package:flutter/material.dart';
import '../component_config.dart';
import 'builder_context.dart';
import 'parsers.dart';

/// Builder for layout components (Column, Row, Container, etc.)
/// These are Flutter primitives, not EAE components
class LayoutComponentBuilder extends ComponentBuilder {
  @override
  List<String> get supportedTypes => [
        'column',
        'row',
        'container',
        'padding',
        'center',
        'expanded',
        'sizedbox',
        'sized_box',
        'spacer',
      ];

  @override
  Widget build(ComponentConfig config, BuilderContext context) {
    switch (config.type.toLowerCase()) {
      case 'column':
        return _buildColumn(config, context);
      case 'row':
        return _buildRow(config, context);
      case 'container':
        return _buildContainer(config, context);
      case 'padding':
        return _buildPadding(config, context);
      case 'center':
        return _buildCenter(config, context);
      case 'expanded':
        return _buildExpanded(config, context);
      case 'sizedbox':
      case 'sized_box':
        return _buildSizedBox(config, context);
      case 'spacer':
        return _buildSpacer(config);
      default:
        throw ArgumentError('Unsupported layout type: ${config.type}');
    }
  }

  Widget _buildColumn(ComponentConfig config, BuilderContext context) {
    return Column(
      mainAxisAlignment: parseMainAxisAlignment(
        config.getProp<String>('mainAxisAlignment'),
      ),
      crossAxisAlignment: parseCrossAxisAlignment(
        config.getProp<String>('crossAxisAlignment'),
      ),
      mainAxisSize: config.getProp<String>('mainAxisSize') == 'min'
          ? MainAxisSize.min
          : MainAxisSize.max,
      children: context.buildChildren(config.children),
    );
  }

  Widget _buildRow(ComponentConfig config, BuilderContext context) {
    return Row(
      mainAxisAlignment: parseMainAxisAlignment(
        config.getProp<String>('mainAxisAlignment'),
      ),
      crossAxisAlignment: parseCrossAxisAlignment(
        config.getProp<String>('crossAxisAlignment'),
      ),
      mainAxisSize: config.getProp<String>('mainAxisSize') == 'min'
          ? MainAxisSize.min
          : MainAxisSize.max,
      children: context.buildChildren(config.children),
    );
  }

  Widget _buildContainer(ComponentConfig config, BuilderContext context) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = context.buildChild(config.children!.first);
    }

    return Container(
      width: config.getProp<double>('width'),
      height: config.getProp<double>('height'),
      padding: parseEdgeInsets(config.getProp<dynamic>('padding')),
      margin: parseEdgeInsets(config.getProp<dynamic>('margin')),
      decoration: BoxDecoration(
        color: config.getProp<Color>('color'),
        borderRadius: BorderRadius.circular(
          config.getProp<double>('borderRadius') ?? 0.0,
        ),
      ),
      child: child,
    );
  }

  Widget _buildPadding(ComponentConfig config, BuilderContext context) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = context.buildChild(config.children!.first);
    }

    return Padding(
      padding:
          parseEdgeInsets(config.getProp<dynamic>('padding')) ?? EdgeInsets.zero,
      child: child,
    );
  }

  Widget _buildCenter(ComponentConfig config, BuilderContext context) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = context.buildChild(config.children!.first);
    }

    return Center(child: child);
  }

  Widget _buildExpanded(ComponentConfig config, BuilderContext context) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = context.buildChild(config.children!.first);
    }

    return Expanded(
      flex: config.getProp<int>('flex') ?? 1,
      child: child ?? const SizedBox(),
    );
  }

  Widget _buildSizedBox(ComponentConfig config, BuilderContext context) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = context.buildChild(config.children!.first);
    }

    return SizedBox(
      width: config.getProp<double>('width'),
      height: config.getProp<double>('height'),
      child: child,
    );
  }

  Widget _buildSpacer(ComponentConfig config) {
    return Spacer(
      flex: config.getProp<int>('flex') ?? 1,
    );
  }
}

