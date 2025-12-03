import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Icon component
class IconSpec extends ComponentSpec {
  @override
  String get type => 'icon';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'icon',
          type: PropType.icon,
          required: true,
          description: 'Icon name',
        ),
        const PropSpec(
          name: 'size',
          type: PropType.enumValue,
          allowedValues: ['xs', 'sm', 'small', 'md', 'medium', 'lg', 'large', 'xl', 'xlarge'],
          defaultValue: 'md',
          description: 'Icon size',
        ),
        const PropSpec(
          name: 'color',
          type: PropType.color,
          description: 'Icon color (hex)',
        ),
        const PropSpec(
          name: 'semanticLabel',
          type: PropType.string,
          description: 'Accessibility label',
        ),
      ];
}

