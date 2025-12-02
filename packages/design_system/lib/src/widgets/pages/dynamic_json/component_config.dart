import 'package:flutter/material.dart';

/// Configuration for a single component in the dynamic screen
class ComponentConfig {
  /// Type of the component (e.g., 'button', 'text', 'text_input')
  final String type;

  /// Properties/parameters for the component
  final Map<String, dynamic> props;

  /// Optional list of child components (for containers or groups)
  final List<ComponentConfig>? children;

  const ComponentConfig({
    required this.type,
    this.props = const {},
    this.children,
  });

  /// Create a ComponentConfig from a JSON map
  factory ComponentConfig.fromJson(Map<String, dynamic> json) {
    return ComponentConfig(
      type: json['type'] as String,
      props: json['props'] as Map<String, dynamic>? ?? {},
      children: json['children'] != null
          ? (json['children'] as List)
              .map((child) => ComponentConfig.fromJson(child as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  /// Convert to JSON map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'props': props,
      if (children != null)
        'children': children!.map((child) => child.toJson()).toList(),
    };
  }

  /// Helper to get a prop value with type safety
  T? getProp<T>(String key, {T? defaultValue}) {
    final value = props[key];
    if (value == null) return defaultValue;
    if (value is T) return value;
    
    // Type conversions
    if (T == Color && value is String) {
      return _parseColor(value) as T?;
    }
    if (T == double && value is int) {
      return value.toDouble() as T;
    }
    if (T == int && value is double) {
      return value.toInt() as T;
    }
    
    return defaultValue;
  }

  /// Parse color from string (hex format)
  static Color? _parseColor(String colorString) {
    if (colorString.startsWith('#')) {
      final hexCode = colorString.substring(1);
      if (hexCode.length == 6) {
        return Color(int.parse('FF$hexCode', radix: 16));
      } else if (hexCode.length == 8) {
        return Color(int.parse(hexCode, radix: 16));
      }
    }
    return null;
  }
}

