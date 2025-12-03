import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for HeightSlider component
class HeightSliderSpec extends ComponentSpec {
  @override
  String get type => 'height_slider';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name',
        ),
        const PropSpec(
          name: 'minValue',
          type: PropType.int,
          defaultValue: 140,
          description: 'Minimum height in cm',
        ),
        const PropSpec(
          name: 'maxValue',
          type: PropType.int,
          defaultValue: 220,
          description: 'Maximum height in cm',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.int,
          defaultValue: 170,
          description: 'Default height value',
        ),
        const PropSpec(
          name: 'label',
          type: PropType.string,
          description: 'Label text',
        ),
        const PropSpec(
          name: 'showCurrentValue',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show current value indicator',
        ),
      ];
}

