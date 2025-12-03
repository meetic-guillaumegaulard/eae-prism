import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for SelectableTagGroup component
class SelectableTagGroupSpec extends ComponentSpec {
  @override
  String get type => 'selectable_tag_group';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name',
        ),
        const PropSpec(
          name: 'labels',
          type: PropType.stringList,
          required: true,
          description: 'List of tag labels',
        ),
        const PropSpec(
          name: 'title',
          type: PropType.string,
          description: 'Group title',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.stringList,
          description: 'Default selected values',
        ),
        const PropSpec(
          name: 'tagSize',
          type: PropType.enumValue,
          allowedValues: ['small', 'medium', 'large'],
          defaultValue: 'medium',
          description: 'Tag size',
        ),
        const PropSpec(
          name: 'tagSpacing',
          type: PropType.double,
          defaultValue: 8.0,
          description: 'Spacing between tags',
        ),
      ];
}

