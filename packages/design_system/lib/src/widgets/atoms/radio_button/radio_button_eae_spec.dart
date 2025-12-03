import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for RadioButton component
class RadioButtonSpec extends ComponentSpec {
  @override
  String get type => 'radio_button';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name (group name)',
        ),
        const PropSpec(
          name: 'value',
          type: PropType.string,
          required: true,
          description: 'Value of this radio option',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.string,
          description: 'Default selected value',
        ),
      ];
}

