import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for SelectionGroup component
class SelectionGroupSpec extends ComponentSpec {
  @override
  String get type => 'selection_group';

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
          description: 'List of option labels',
        ),
        const PropSpec(
          name: 'selectionType',
          type: PropType.enumValue,
          allowedValues: ['checkbox', 'radio'],
          defaultValue: 'checkbox',
          description: 'Selection type',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.string,
          description: 'Default selected value (for radio)',
        ),
        const PropSpec(
          name: 'spacing',
          type: PropType.double,
          defaultValue: 8.0,
          description: 'Spacing between options',
        ),
      ];
}

