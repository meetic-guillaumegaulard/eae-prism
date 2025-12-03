import 'component_spec.dart';

/// Spec for Column component
class ColumnSpec extends ComponentSpec {
  @override
  String get type => 'column';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'mainAxisAlignment',
          type: PropType.enumValue,
          allowedValues: ['start', 'end', 'center', 'spaceBetween', 'spaceAround', 'spaceEvenly'],
          defaultValue: 'start',
          description: 'Main axis alignment',
        ),
        const PropSpec(
          name: 'crossAxisAlignment',
          type: PropType.enumValue,
          allowedValues: ['start', 'end', 'center', 'stretch', 'baseline'],
          defaultValue: 'center',
          description: 'Cross axis alignment',
        ),
        const PropSpec(
          name: 'mainAxisSize',
          type: PropType.enumValue,
          allowedValues: ['min', 'max'],
          defaultValue: 'max',
          description: 'Main axis size',
        ),
      ];
}

/// Spec for Row component
class RowSpec extends ComponentSpec {
  @override
  String get type => 'row';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'mainAxisAlignment',
          type: PropType.enumValue,
          allowedValues: ['start', 'end', 'center', 'spaceBetween', 'spaceAround', 'spaceEvenly'],
          defaultValue: 'start',
          description: 'Main axis alignment',
        ),
        const PropSpec(
          name: 'crossAxisAlignment',
          type: PropType.enumValue,
          allowedValues: ['start', 'end', 'center', 'stretch', 'baseline'],
          defaultValue: 'center',
          description: 'Cross axis alignment',
        ),
        const PropSpec(
          name: 'mainAxisSize',
          type: PropType.enumValue,
          allowedValues: ['min', 'max'],
          defaultValue: 'max',
          description: 'Main axis size',
        ),
      ];
}

/// Spec for Container component
class ContainerSpec extends ComponentSpec {
  @override
  String get type => 'container';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'width',
          type: PropType.double,
          description: 'Container width',
        ),
        const PropSpec(
          name: 'height',
          type: PropType.double,
          description: 'Container height',
        ),
        const PropSpec(
          name: 'padding',
          type: PropType.padding,
          description: 'Padding (number or {left, top, right, bottom})',
        ),
        const PropSpec(
          name: 'margin',
          type: PropType.padding,
          description: 'Margin (number or {left, top, right, bottom})',
        ),
        const PropSpec(
          name: 'color',
          type: PropType.color,
          description: 'Background color (hex string)',
        ),
        const PropSpec(
          name: 'borderRadius',
          type: PropType.double,
          defaultValue: 0.0,
          description: 'Border radius',
        ),
      ];
}

/// Spec for Padding component
class PaddingSpec extends ComponentSpec {
  @override
  String get type => 'padding';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'padding',
          type: PropType.padding,
          required: true,
          description: 'Padding value (number or {left, top, right, bottom})',
        ),
      ];
}

/// Spec for Center component
class CenterSpec extends ComponentSpec {
  @override
  String get type => 'center';

  @override
  List<PropSpec> get props => [];
}

/// Spec for Expanded component
class ExpandedSpec extends ComponentSpec {
  @override
  String get type => 'expanded';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'flex',
          type: PropType.int,
          defaultValue: 1,
          description: 'Flex factor',
        ),
      ];
}

/// Spec for SizedBox component
class SizedBoxSpec extends ComponentSpec {
  @override
  String get type => 'sizedbox';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'width',
          type: PropType.double,
          description: 'Width',
        ),
        const PropSpec(
          name: 'height',
          type: PropType.double,
          description: 'Height',
        ),
      ];
}

/// Spec for Spacer component
class SpacerSpec extends ComponentSpec {
  @override
  String get type => 'spacer';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'flex',
          type: PropType.int,
          defaultValue: 1,
          description: 'Flex factor',
        ),
      ];
}

/// Register all layout specs
void registerLayoutSpecs() {
  ComponentSpecRegistry.register(ColumnSpec());
  ComponentSpecRegistry.register(RowSpec());
  ComponentSpecRegistry.register(ContainerSpec());
  ComponentSpecRegistry.register(PaddingSpec());
  ComponentSpecRegistry.register(CenterSpec());
  ComponentSpecRegistry.register(ExpandedSpec());
  ComponentSpecRegistry.register(SizedBoxSpec());
  ComponentSpecRegistry.register(SpacerSpec());
}

