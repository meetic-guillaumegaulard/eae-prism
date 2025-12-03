import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Header component
class HeaderSpec extends ComponentSpec {
  @override
  String get type => 'header';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'icon',
          type: PropType.icon,
          required: true,
          description: 'Header icon name',
        ),
        const PropSpec(
          name: 'text',
          type: PropType.string,
          required: true,
          description: 'Header text',
        ),
        const PropSpec(
          name: 'onBackAction',
          type: PropType.string,
          description: 'Action name for back button',
        ),
        const PropSpec(
          name: 'showBackgroundIcon',
          type: PropType.bool,
          defaultValue: true,
          description: 'Show background icon decoration',
        ),
        const PropSpec(
          name: 'backgroundIconSize',
          type: PropType.double,
          defaultValue: 200.0,
          description: 'Background icon size',
        ),
        const PropSpec(
          name: 'backgroundIconOpacity',
          type: PropType.double,
          defaultValue: 0.15,
          description: 'Background icon opacity',
        ),
      ];
}

