import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for LabeledControl component
class LabeledControlSpec extends ComponentSpec {
  @override
  String get type => 'labeled_control';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'htmlLabel',
          type: PropType.string,
          description: 'HTML label text (supports links)',
        ),
        const PropSpec(
          name: 'label',
          type: PropType.string,
          description: 'Plain text label (fallback)',
        ),
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name',
        ),
        const PropSpec(
          name: 'controlType',
          type: PropType.enumValue,
          allowedValues: ['checkbox', 'toggle'],
          defaultValue: 'checkbox',
          description: 'Control type',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.bool,
          defaultValue: false,
          description: 'Default checked state',
        ),
        const PropSpec(
          name: 'expanded',
          type: PropType.bool,
          defaultValue: true,
          description: 'Expand label to fill space',
        ),
      ];
}

