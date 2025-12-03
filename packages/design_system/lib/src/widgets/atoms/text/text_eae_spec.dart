import '../../pages/dynamic_json/shared/component_spec.dart';

/// Spec for Text component
class TextSpec extends ComponentSpec {
  @override
  String get type => 'text';

  @override
  List<PropSpec> get props => [
        const PropSpec(
          name: 'text',
          type: PropType.string,
          required: true,
          description: 'Text content',
        ),
        const PropSpec(
          name: 'type',
          type: PropType.enumValue,
          allowedValues: [
            'displayLarge', 'displayMedium', 'displaySmall',
            'headlineLarge', 'headlineMedium', 'headlineSmall',
            'titleLarge', 'titleMedium', 'titleSmall',
            'bodyLarge', 'bodyMedium', 'bodySmall',
            'labelLarge', 'labelMedium', 'labelSmall',
          ],
          defaultValue: 'bodyMedium',
          description: 'Text style type',
        ),
        const PropSpec(
          name: 'color',
          type: PropType.color,
          description: 'Text color (hex)',
        ),
        const PropSpec(
          name: 'fontWeight',
          type: PropType.enumValue,
          allowedValues: ['thin', 'extralight', 'light', 'normal', 'medium', 'semibold', 'bold', 'extrabold', 'black'],
          description: 'Font weight',
        ),
        const PropSpec(
          name: 'textAlign',
          type: PropType.enumValue,
          allowedValues: ['left', 'right', 'center', 'justify', 'start', 'end'],
          description: 'Text alignment',
        ),
        const PropSpec(
          name: 'maxLines',
          type: PropType.int,
          description: 'Maximum lines to display',
        ),
        const PropSpec(
          name: 'overflow',
          type: PropType.enumValue,
          allowedValues: ['clip', 'fade', 'ellipsis', 'visible'],
          description: 'Text overflow behavior',
        ),
      ];
}

