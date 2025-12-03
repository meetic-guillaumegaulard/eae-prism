import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Checkbox component
class CheckboxSpec extends ComponentSpec {
  @override
  String get type => 'checkbox';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.bool,
          defaultValue: false,
          description: 'Default checked state',
        ),
      ];
}

