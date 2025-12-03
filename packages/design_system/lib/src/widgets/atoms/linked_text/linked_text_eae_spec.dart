import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for LinkedText component
class LinkedTextSpec extends ComponentSpec {
  @override
  String get type => 'linked_text';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'htmlText',
          type: PropType.string,
          description: 'HTML text with links',
        ),
        const PropSpec(
          name: 'text',
          type: PropType.string,
          description: 'Plain text (fallback)',
        ),
        const PropSpec(
          name: 'textAlign',
          type: PropType.enumValue,
          allowedValues: ['left', 'right', 'center', 'justify', 'start', 'end'],
          defaultValue: 'start',
          description: 'Text alignment',
        ),
      ];
}

