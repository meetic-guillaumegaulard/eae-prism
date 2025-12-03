import 'package:flutter/foundation.dart';

/// Manages the form state for dynamic screens
/// Automatically collects values from components based on their field path
class FormStateManager extends ChangeNotifier {
  final Map<String, dynamic> _values = {};

  /// Get all form values as a flat map
  Map<String, dynamic> get values => Map.unmodifiable(_values);

  /// Get form values as a nested JSON structure
  /// Field paths like "user.name" become {"user": {"name": "value"}}
  Map<String, dynamic> get nestedValues {
    final result = <String, dynamic>{};

    for (final entry in _values.entries) {
      _setNestedValue(result, entry.key, entry.value);
    }

    return result;
  }

  /// Get a specific value by field path
  T? getValue<T>(String field) {
    final value = _values[field];
    if (value == null) return null;

    // Handle List<dynamic> to List<String> conversion
    if (value is List && T == List<String>) {
      return value.map((e) => e.toString()).toList() as T;
    }

    // Handle List<dynamic> to List<dynamic> (just return as-is)
    if (value is List) {
      return value as T;
    }

    return value as T?;
  }

  /// Set a value for a field
  void setValue(String field, dynamic value) {
    if (_values[field] != value) {
      _values[field] = value;
      notifyListeners();
    }
  }

  /// Set multiple values at once
  void setValues(Map<String, dynamic> values) {
    bool changed = false;
    for (final entry in values.entries) {
      if (_values[entry.key] != entry.value) {
        _values[entry.key] = entry.value;
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  /// Initialize with default values from the screen config
  void initializeDefaults(Map<String, dynamic> defaults) {
    for (final entry in defaults.entries) {
      _values.putIfAbsent(entry.key, () => entry.value);
    }
  }

  /// Clear all values
  void clear() {
    _values.clear();
    notifyListeners();
  }

  /// Reset to specific values
  void reset(Map<String, dynamic> values) {
    _values.clear();
    _values.addAll(values);
    notifyListeners();
  }

  /// Helper to set a nested value from a dot-notation path
  void _setNestedValue(Map<String, dynamic> map, String path, dynamic value) {
    final parts = path.split('.');
    var current = map;

    for (int i = 0; i < parts.length - 1; i++) {
      final part = parts[i];
      current[part] ??= <String, dynamic>{};
      if (current[part] is Map<String, dynamic>) {
        current = current[part] as Map<String, dynamic>;
      } else {
        // If it's not a map, we can't nest further
        return;
      }
    }

    current[parts.last] = value;
  }
}
