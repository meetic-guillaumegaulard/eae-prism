import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Logo component
class LogoSpec extends ComponentSpec {
  @override
  String get type => 'logo';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'brand',
          type: PropType.enumValue,
          allowedValues: ['match', 'meetic', 'okc', 'okcupid', 'pof', 'plentyoffish'],
          defaultValue: 'match',
          description: 'Brand name',
        ),
        const PropSpec(
          name: 'logoType',
          type: PropType.enumValue,
          allowedValues: ['small', 'onDark', 'onWhite', 'on_dark', 'on_white'],
          defaultValue: 'onWhite',
          description: 'Logo type/variant',
        ),
        const PropSpec(
          name: 'height',
          type: PropType.double,
          description: 'Logo height',
        ),
      ];
}

