import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Slider component
class SliderSpec extends ComponentSpec {
  @override
  String get type => 'slider';

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
          defaultValue: 0,
          description: 'Minimum value',
        ),
        const PropSpec(
          name: 'maxValue',
          type: PropType.int,
          defaultValue: 100,
          description: 'Maximum value',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.int,
          description: 'Default value',
        ),
        const PropSpec(
          name: 'label',
          type: PropType.string,
          description: 'Label text',
        ),
        const PropSpec(
          name: 'showLabels',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show value labels',
        ),
        const PropSpec(
          name: 'showMinMaxLabels',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show min/max labels',
        ),
      ];
}

/// Spec for SliderRange component
class SliderRangeSpec extends ComponentSpec {
  @override
  String get type => 'slider_range';

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
          defaultValue: 0,
          description: 'Minimum value',
        ),
        const PropSpec(
          name: 'maxValue',
          type: PropType.int,
          defaultValue: 100,
          description: 'Maximum value',
        ),
        const PropSpec(
          name: 'defaultStart',
          type: PropType.int,
          description: 'Default range start',
        ),
        const PropSpec(
          name: 'defaultEnd',
          type: PropType.int,
          description: 'Default range end',
        ),
        const PropSpec(
          name: 'label',
          type: PropType.string,
          description: 'Label text',
        ),
        const PropSpec(
          name: 'showLabels',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show value labels',
        ),
        const PropSpec(
          name: 'showMinMaxLabels',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show min/max labels',
        ),
      ];
}

