import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Tag component
class TagSpec extends ComponentSpec {
  @override
  String get type => 'tag';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'label',
          type: PropType.string,
          required: true,
          description: 'Tag label',
        ),
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name (for selectable tags)',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.bool,
          defaultValue: false,
          description: 'Default selected state',
        ),
        const PropSpec(
          name: 'size',
          type: PropType.enumValue,
          allowedValues: ['small', 'medium', 'large'],
          defaultValue: 'medium',
          description: 'Tag size',
        ),
      ];
}

