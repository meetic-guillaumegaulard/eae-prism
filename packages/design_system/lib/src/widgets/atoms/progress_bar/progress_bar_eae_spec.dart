import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for ProgressBar component
class ProgressBarSpec extends ComponentSpec {
  @override
  String get type => 'progress_bar';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'value',
          type: PropType.int,
          description: 'Current progress value',
        ),
        const PropSpec(
          name: 'progress',
          type: PropType.double,
          description: 'Progress as 0-1 (alternative to value)',
        ),
        const PropSpec(
          name: 'min',
          type: PropType.int,
          defaultValue: 0,
          description: 'Minimum value',
        ),
        const PropSpec(
          name: 'max',
          type: PropType.int,
          defaultValue: 100,
          description: 'Maximum value',
        ),
        const PropSpec(
          name: 'showPercentage',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show percentage counter',
        ),
        const PropSpec(
          name: 'showCounter',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show counter (alias for showPercentage)',
        ),
      ];
}

