import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Toggle component
class ToggleSpec extends ComponentSpec {
  @override
  String get type => 'toggle';

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
          description: 'Default toggle state',
        ),
      ];
}

