import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for SelectableButton component
class SelectableButtonSpec extends ComponentSpec {
  @override
  String get type => 'selectable_button';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'label',
          type: PropType.string,
          required: true,
          description: 'Button label',
        ),
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.bool,
          defaultValue: false,
          description: 'Default selected state',
        ),
        const PropSpec(
          name: 'size',
          type: PropType.enumValue,
          allowedValues: ['small', 'medium', 'large'],
          defaultValue: 'medium',
          description: 'Button size',
        ),
        const PropSpec(
          name: 'isFullWidth',
          type: PropType.bool,
          defaultValue: false,
          description: 'Expand to full width',
        ),
      ];
}

