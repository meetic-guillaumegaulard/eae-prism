/// Base class for component specifications
///
/// Defines the schema for validating component properties from JSON

/// Represents a property definition for a component
class PropSpec {
  /// Name of the property
  final String name;

  /// Type of the property (for documentation and runtime checks)
  final PropType type;

  /// Whether this property is required
  final bool required;

  /// Default value if not provided
  final dynamic defaultValue;

  /// Description for documentation
  final String? description;

  /// Allowed values for enum types
  final List<String>? allowedValues;

  const PropSpec({
    required this.name,
    required this.type,
    this.required = false,
    this.defaultValue,
    this.description,
    this.allowedValues,
  });
}

/// Supported property types
enum PropType {
  string,
  int,
  double,
  bool,
  color,
  icon,
  stringList,
  padding,
  children,
  component,
  enumValue,
  map,
}

/// Base class for all component specifications
abstract class ComponentSpec {
  /// The component type name (used in JSON "type" field)
  String get type;

  /// List of all properties this component accepts
  List<PropSpec> get props;

  /// Validates a props map against this spec
  /// Returns a list of validation errors, empty if valid
  List<String> validate(Map<String, dynamic> props) {
    final errors = <String>[];

    // Check required props
    for (final prop in this.props.where((p) => p.required)) {
      if (!props.containsKey(prop.name) || props[prop.name] == null) {
        errors.add('Missing required property: ${prop.name}');
      }
    }

    // Check enum values
    for (final prop in this.props.where((p) => p.allowedValues != null)) {
      final value = props[prop.name];
      if (value != null &&
          !prop.allowedValues!.contains(value.toString().toLowerCase())) {
        errors.add(
          'Invalid value for ${prop.name}: $value. '
          'Allowed: ${prop.allowedValues!.join(", ")}',
        );
      }
    }

    return errors;
  }

  /// Returns the default value for a property
  dynamic getDefaultValue(String propName) {
    final prop = props.firstWhere(
      (p) => p.name == propName,
      orElse: () => throw ArgumentError('Unknown property: $propName'),
    );
    return prop.defaultValue;
  }
}

/// Registry of all component specifications
class ComponentSpecRegistry {
  static final Map<String, ComponentSpec> _specs = {};

  /// Register a component spec
  static void register(ComponentSpec spec) {
    _specs[spec.type.toLowerCase()] = spec;
  }

  /// Get a spec by type name
  static ComponentSpec? getSpec(String type) {
    return _specs[type.toLowerCase()];
  }

  /// Validate a component config
  static List<String> validate(String type, Map<String, dynamic> props) {
    final spec = getSpec(type);
    if (spec == null) {
      return ['Unknown component type: $type'];
    }
    return spec.validate(props);
  }

  /// Check if a type is registered
  static bool hasSpec(String type) => _specs.containsKey(type.toLowerCase());

  /// Get all registered types
  static List<String> get registeredTypes => _specs.keys.toList();
}

