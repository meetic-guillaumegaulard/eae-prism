import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for SelectableButtonGroup component
class SelectableButtonGroupSpec extends ComponentSpec {
  @override
  String get type => 'selectable_button_group';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name',
        ),
        const PropSpec(
          name: 'labels',
          type: PropType.stringList,
          required: true,
          description: 'List of button labels',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.string,
          description: 'Default selected value',
        ),
        const PropSpec(
          name: 'spacing',
          type: PropType.double,
          defaultValue: 8.0,
          description: 'Spacing between buttons',
        ),
        const PropSpec(
          name: 'size',
          type: PropType.enumValue,
          allowedValues: ['small', 'medium', 'large'],
          defaultValue: 'medium',
          description: 'Button size',
        ),
      ];
}

