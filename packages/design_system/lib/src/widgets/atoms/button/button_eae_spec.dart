import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Button component
class ButtonSpec extends ComponentSpec {
  @override
  String get type => 'button';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'label',
          type: PropType.string,
          required: true,
          description: 'Button label text',
        ),
        const PropSpec(
          name: 'variant',
          type: PropType.enumValue,
          allowedValues: ['primary', 'secondary', 'outline'],
          defaultValue: 'primary',
          description: 'Button style variant',
        ),
        const PropSpec(
          name: 'size',
          type: PropType.enumValue,
          allowedValues: ['small', 'medium', 'large'],
          defaultValue: 'medium',
          description: 'Button size',
        ),
        const PropSpec(
          name: 'isLoading',
          type: PropType.bool,
          defaultValue: false,
          description: 'Show loading indicator',
        ),
        const PropSpec(
          name: 'isFullWidth',
          type: PropType.bool,
          defaultValue: false,
          description: 'Expand to full width',
        ),
        const PropSpec(
          name: 'icon',
          type: PropType.icon,
          description: 'Icon name (e.g., "add", "check")',
        ),
        const PropSpec(
          name: 'action',
          type: PropType.string,
          description: 'Action callback name',
        ),
        const PropSpec(
          name: 'apiEndpoint',
          type: PropType.string,
          description: 'API endpoint for form submission',
        ),
      ];
}

