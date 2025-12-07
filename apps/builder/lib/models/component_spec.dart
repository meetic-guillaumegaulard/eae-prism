/// Model for component specifications
class ComponentSpec {
  final String type;
  final String label;
  final String description;
  final bool hasChildren;
  final Map<String, PropSpec> props;

  const ComponentSpec({
    required this.type,
    required this.label,
    required this.description,
    this.hasChildren = false,
    required this.props,
  });

  factory ComponentSpec.fromJson(Map<String, dynamic> json) {
    final propsJson = json['props'] as Map<String, dynamic>? ?? {};
    return ComponentSpec(
      type: json['type'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
      hasChildren: json['hasChildren'] as bool? ?? false,
      props: propsJson.map(
        (key, value) => MapEntry(key, PropSpec.fromJson(value as Map<String, dynamic>)),
      ),
    );
  }
}

/// Model for property specifications
class PropSpec {
  final String type;
  final bool required;
  final dynamic defaultValue;
  final List<String>? enumValues;

  const PropSpec({
    required this.type,
    this.required = false,
    this.defaultValue,
    this.enumValues,
  });

  factory PropSpec.fromJson(Map<String, dynamic> json) {
    return PropSpec(
      type: json['type'] as String,
      required: json['required'] as bool? ?? false,
      defaultValue: json['default'],
      enumValues: (json['values'] as List?)?.cast<String>(),
    );
  }
}

/// Parse all component specs from API response
class ComponentSpecs {
  final List<ComponentSpec> templates;
  final List<ComponentSpec> atoms;
  final List<ComponentSpec> molecules;
  final List<ComponentSpec> layouts;

  const ComponentSpecs({
    required this.templates,
    required this.atoms,
    required this.molecules,
    required this.layouts,
  });

  factory ComponentSpecs.fromJson(Map<String, dynamic> json) {
    return ComponentSpecs(
      templates: (json['templates'] as List)
          .map((item) => ComponentSpec.fromJson(item as Map<String, dynamic>))
          .toList(),
      atoms: (json['atoms'] as List)
          .map((item) => ComponentSpec.fromJson(item as Map<String, dynamic>))
          .toList(),
      molecules: (json['molecules'] as List)
          .map((item) => ComponentSpec.fromJson(item as Map<String, dynamic>))
          .toList(),
      layouts: (json['layouts'] as List)
          .map((item) => ComponentSpec.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all component specs as a flat list
  List<ComponentSpec> get all => [...templates, ...atoms, ...molecules, ...layouts];

  /// Find a component spec by type
  ComponentSpec? findByType(String type) {
    for (final spec in all) {
      if (spec.type == type) return spec;
    }
    return null;
  }
}

