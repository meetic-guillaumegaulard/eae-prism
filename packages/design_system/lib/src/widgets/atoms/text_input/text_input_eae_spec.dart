import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for TextInput component
class TextInputSpec extends ComponentSpec {
  @override
  String get type => 'text_input';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'field',
          type: PropType.string,
          description: 'Form field name for value collection',
        ),
        const PropSpec(
          name: 'label',
          type: PropType.string,
          description: 'Input label',
        ),
        const PropSpec(
          name: 'hintText',
          type: PropType.string,
          description: 'Placeholder text',
        ),
        const PropSpec(
          name: 'obscureText',
          type: PropType.bool,
          defaultValue: false,
          description: 'Hide input (for passwords)',
        ),
        const PropSpec(
          name: 'enabled',
          type: PropType.bool,
          defaultValue: true,
          description: 'Enable input',
        ),
        const PropSpec(
          name: 'errorText',
          type: PropType.string,
          description: 'Error message to display',
        ),
        const PropSpec(
          name: 'defaultValue',
          type: PropType.string,
          defaultValue: '',
          description: 'Default value',
        ),
      ];
}

