import 'package:flutter/material.dart';
import '../models/component_spec.dart';
import 'navigation_editor.dart';

class PropertyEditor extends StatelessWidget {
  final Map<String, dynamic>? component;
  final String? componentPath;
  final ComponentSpecs? specs;
  final void Function(String path, Map<String, dynamic> props) onUpdate;
  final Map<String, dynamic>? navigationConfig;
  final void Function(Map<String, dynamic> navigation)? onNavigationUpdate;

  const PropertyEditor({
    super.key,
    this.component,
    this.componentPath,
    this.specs,
    required this.onUpdate,
    this.navigationConfig,
    this.onNavigationUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.tune, size: 16, color: Color(0xFF00E4D7)),
              SizedBox(width: 8),
              Text(
                'Properties',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: component == null || componentPath == null
              ? _buildEmptyState()
              : _buildPropertyList(context),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app,
            size: 48,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 12),
          Text(
            'Select a component',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'to edit its properties',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyList(BuildContext context) {
    final type = component!['type'] as String? ?? 'unknown';
    final props = Map<String, dynamic>.from(component!['props'] ?? {});
    final spec = specs?.findByType(type);
    final isScreen = type == 'screen';

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Component type header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2D1B4E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E4D7).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  isScreen ? Icons.web : _getIconForType(type),
                  size: 18,
                  color: const Color(0xFF00E4D7),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spec?.label ?? type,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (spec != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        spec.description,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),

        // Navigation Editor (Only for screen)
        if (isScreen && onNavigationUpdate != null) ...[
          const SizedBox(height: 16),
          NavigationEditor(
            navigation: navigationConfig,
            onUpdate: onNavigationUpdate!,
          ),
        ],

        const SizedBox(height: 16),

        // Properties
        if (spec != null)
          ...spec.props.entries.map((entry) {
            return _buildPropertyField(
              context,
              entry.key,
              entry.value,
              props[entry.key],
              props,
            );
          })
        else
          ..._buildDynamicProperties(context, props),
      ],
    );
  }

  List<Widget> _buildDynamicProperties(
    BuildContext context,
    Map<String, dynamic> props,
  ) {
    return props.entries.map((entry) {
      final value = entry.value;
      PropSpec propSpec;

      if (value is bool) {
        propSpec = const PropSpec(type: 'boolean');
      } else if (value is int || value is double) {
        propSpec = const PropSpec(type: 'number');
      } else if (value is String && value.startsWith('#')) {
        propSpec = const PropSpec(type: 'color');
      } else {
        propSpec = const PropSpec(type: 'string');
      }

      return _buildPropertyField(
        context,
        entry.key,
        propSpec,
        value,
        props,
      );
    }).toList();
  }

  Widget _buildPropertyField(
    BuildContext context,
    String key,
    PropSpec propSpec,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _formatPropertyName(key),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
              if (propSpec.required) ...[
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          _buildInputField(context, key, propSpec, currentValue, allProps),
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context,
    String key,
    PropSpec propSpec,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    switch (propSpec.type) {
      case 'string':
        return _buildStringInput(key, currentValue, allProps);
      case 'number':
        return _buildNumberInput(key, currentValue, allProps);
      case 'boolean':
        return _buildBooleanInput(key, currentValue, allProps);
      case 'color':
        return _buildColorInput(key, currentValue, allProps);
      case 'enum':
        return _buildEnumInput(
            key, propSpec.enumValues ?? [], currentValue, allProps);
      default:
        return _buildStringInput(key, currentValue?.toString(), allProps);
    }
  }

  Widget _buildStringInput(
    String key,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    return TextFormField(
      initialValue: currentValue?.toString() ?? '',
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        hintText: 'Enter a value...',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 13,
        ),
      ),
      style: const TextStyle(fontSize: 13, color: Colors.white),
      onChanged: (value) {
        _updateProperty(key, value.isEmpty ? null : value);
      },
    );
  }

  Widget _buildNumberInput(
    String key,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    return TextFormField(
      initialValue: currentValue?.toString() ?? '',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        hintText: '0',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 13,
        ),
      ),
      style: const TextStyle(fontSize: 13, color: Colors.white),
      onChanged: (value) {
        if (value.isEmpty) {
          _updateProperty(key, null);
        } else {
          final num? parsed = num.tryParse(value);
          if (parsed != null) {
            _updateProperty(key, parsed);
          }
        }
      },
    );
  }

  Widget _buildBooleanInput(
    String key,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    return Row(
      children: [
        Switch(
          value: currentValue == true,
          onChanged: (value) => _updateProperty(key, value),
          activeTrackColor: const Color(0xFF00E4D7),
        ),
        const SizedBox(width: 8),
        Text(
          currentValue == true ? 'Enabled' : 'Disabled',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildColorInput(
    String key,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    final colorString = currentValue?.toString() ?? '#FFFFFF';
    Color? color;
    try {
      if (colorString.startsWith('#') && colorString.length == 7) {
        color = Color(int.parse('FF${colorString.substring(1)}', radix: 16));
      }
    } catch (_) {}

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            initialValue: colorString,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              hintText: '#FFFFFF',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 13,
              ),
            ),
            style: const TextStyle(fontSize: 13, color: Colors.white),
            onChanged: (value) {
              if (value.isEmpty ||
                  (value.startsWith('#') && value.length == 7)) {
                _updateProperty(key, value.isEmpty ? null : value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEnumInput(
    String key,
    List<String> values,
    dynamic currentValue,
    Map<String, dynamic> allProps,
  ) {
    return DropdownButtonFormField<String>(
      initialValue:
          values.contains(currentValue) ? currentValue as String : null,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        hintText: 'Select...',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 13,
        ),
      ),
      dropdownColor: const Color(0xFF2D1B4E),
      style: const TextStyle(fontSize: 13, color: Colors.white),
      items: values.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) => _updateProperty(key, value),
    );
  }

  void _updateProperty(String key, dynamic value) {
    if (componentPath == null) return;
    onUpdate(componentPath!, {key: value});
  }

  String _formatPropertyName(String key) {
    // Convert camelCase to Title Case
    return key
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => ' ${match.group(0)}',
        )
        .trim()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'text':
        return Icons.text_fields;
      case 'button':
        return Icons.smart_button;
      case 'text_input':
        return Icons.edit;
      case 'checkbox':
        return Icons.check_box_outlined;
      case 'toggle':
        return Icons.toggle_on_outlined;
      case 'slider':
        return Icons.linear_scale;
      case 'progress_bar':
        return Icons.percent;
      case 'icon':
        return Icons.emoji_emotions_outlined;
      case 'logo':
        return Icons.branding_watermark;
      case 'header':
        return Icons.title;
      case 'selection_group':
        return Icons.checklist;
      case 'container':
        return Icons.crop_square;
      case 'column':
        return Icons.view_column;
      case 'row':
        return Icons.view_stream;
      case 'padding':
        return Icons.padding;
      default:
        return Icons.widgets;
    }
  }
}
