import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for LandingScreen template
class LandingScreenSpec extends ComponentSpec {
  @override
  String get type => 'landing_screen';

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
          name: 'mobileLogoType',
          type: PropType.enumValue,
          allowedValues: ['small', 'onDark', 'onWhite', 'on_dark', 'on_white'],
          defaultValue: 'onDark',
          description: 'Logo type for mobile',
        ),
        const PropSpec(
          name: 'desktopLogoType',
          type: PropType.enumValue,
          allowedValues: ['small', 'onDark', 'onWhite', 'on_dark', 'on_white'],
          defaultValue: 'small',
          description: 'Logo type for desktop',
        ),
        const PropSpec(
          name: 'mobileLogoHeight',
          type: PropType.double,
          description: 'Mobile logo height',
        ),
        const PropSpec(
          name: 'desktopLogoHeight',
          type: PropType.double,
          description: 'Desktop logo height',
        ),
        const PropSpec(
          name: 'topBarButtonText',
          type: PropType.string,
          description: 'Top bar button text',
        ),
        const PropSpec(
          name: 'topBarButtonAction',
          type: PropType.string,
          description: 'Top bar button action name',
        ),
        const PropSpec(
          name: 'bottomBar',
          type: PropType.component,
          description: 'Bottom bar component config',
        ),
      ];
}

