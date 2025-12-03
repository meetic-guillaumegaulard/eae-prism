import 'package:flutter/material.dart';
import 'component_config.dart';
import 'form_state_manager.dart';
import 'shared/shared.dart';

// Atoms builders
import '../../atoms/button/button_eae_builder.dart';
import '../../atoms/text/text_eae_builder.dart';
import '../../atoms/text_input/text_input_eae_builder.dart';
import '../../atoms/checkbox/checkbox_eae_builder.dart';
import '../../atoms/radio_button/radio_button_eae_builder.dart';
import '../../atoms/toggle/toggle_eae_builder.dart';
import '../../atoms/height_slider/height_slider_eae_builder.dart';
import '../../atoms/slider/slider_eae_builder.dart';
import '../../atoms/linked_text/linked_text_eae_builder.dart';
import '../../atoms/tag/tag_eae_builder.dart';
import '../../atoms/progress_bar/progress_bar_eae_builder.dart';
import '../../atoms/selectable_button/selectable_button_eae_builder.dart';
import '../../atoms/logo/logo_eae_builder.dart';
import '../../atoms/icon/icon_eae_builder.dart';

// Atoms specs
import '../../atoms/button/button_eae_spec.dart';
import '../../atoms/text/text_eae_spec.dart';
import '../../atoms/text_input/text_input_eae_spec.dart';
import '../../atoms/checkbox/checkbox_eae_spec.dart';
import '../../atoms/radio_button/radio_button_eae_spec.dart';
import '../../atoms/toggle/toggle_eae_spec.dart';
import '../../atoms/height_slider/height_slider_eae_spec.dart';
import '../../atoms/slider/slider_eae_spec.dart';
import '../../atoms/linked_text/linked_text_eae_spec.dart';
import '../../atoms/tag/tag_eae_spec.dart';
import '../../atoms/progress_bar/progress_bar_eae_spec.dart';
import '../../atoms/selectable_button/selectable_button_eae_spec.dart';
import '../../atoms/logo/logo_eae_spec.dart';
import '../../atoms/icon/icon_eae_spec.dart';

// Molecules builders
import '../../molecules/header/header_eae_builder.dart';
import '../../molecules/labeled_control/labeled_control_eae_builder.dart';
import '../../molecules/selection_group/selection_group_eae_builder.dart';
import '../../molecules/selectable_button_group/selectable_button_group_eae_builder.dart';
import '../../molecules/selectable_tag_group/selectable_tag_group_eae_builder.dart';

// Molecules specs
import '../../molecules/header/header_eae_spec.dart';
import '../../molecules/labeled_control/labeled_control_eae_spec.dart';
import '../../molecules/selection_group/selection_group_eae_spec.dart';
import '../../molecules/selectable_button_group/selectable_button_group_eae_spec.dart';
import '../../molecules/selectable_tag_group/selectable_tag_group_eae_spec.dart';

// Templates builders
import '../../templates/landing_screen/landing_screen_eae_builder.dart';

// Templates specs
import '../../templates/landing_screen/landing_screen_eae_spec.dart';

/// Re-export for backward compatibility
export 'shared/builder_context.dart' show ApiActionCallback, ExitCallback;

/// Initialize all component specs for validation
/// Call this once at app startup if you want to use validation
void initializeComponentSpecs() {
  // Layout specs
  registerLayoutSpecs();

  // Atom specs
  ComponentSpecRegistry.register(ButtonSpec());
  ComponentSpecRegistry.register(TextSpec());
  ComponentSpecRegistry.register(TextInputSpec());
  ComponentSpecRegistry.register(CheckboxSpec());
  ComponentSpecRegistry.register(RadioButtonSpec());
  ComponentSpecRegistry.register(ToggleSpec());
  ComponentSpecRegistry.register(HeightSliderSpec());
  ComponentSpecRegistry.register(SliderSpec());
  ComponentSpecRegistry.register(SliderRangeSpec());
  ComponentSpecRegistry.register(LinkedTextSpec());
  ComponentSpecRegistry.register(TagSpec());
  ComponentSpecRegistry.register(ProgressBarSpec());
  ComponentSpecRegistry.register(SelectableButtonSpec());
  ComponentSpecRegistry.register(LogoSpec());
  ComponentSpecRegistry.register(IconSpec());

  // Molecule specs
  ComponentSpecRegistry.register(HeaderSpec());
  ComponentSpecRegistry.register(LabeledControlSpec());
  ComponentSpecRegistry.register(SelectionGroupSpec());
  ComponentSpecRegistry.register(SelectableButtonGroupSpec());
  ComponentSpecRegistry.register(SelectableTagGroupSpec());

  // Template specs
  ComponentSpecRegistry.register(LandingScreenSpec());
}

/// Factory class to build Flutter widgets from ComponentConfig
///
/// Uses a modular architecture with separate builders for each component.
/// Each component has its builder in the same folder as the widget.
class ComponentFactory {
  /// Form state manager to automatically collect values
  final FormStateManager formState;

  /// Callback pour les appels API
  final ApiActionCallback? onApiAction;

  /// Callback appelé quand un composant a une propriété "exit"
  /// Reçoit la destination et les valeurs du formulaire
  final ExitCallback? onExit;

  /// Whether to validate components before building
  final bool validateBeforeBuild;

  /// List of registered builders
  final List<ComponentBuilder> _builders;

  /// Lazily created build context
  BuilderContext? _buildContext;

  ComponentFactory({
    required this.formState,
    this.onApiAction,
    this.onExit,
    this.validateBeforeBuild = false,
  }) : _builders = [
          // Layouts
          LayoutComponentBuilder(),
          // Atoms
          ButtonBuilder(),
          TextBuilder(),
          TextInputBuilder(),
          CheckboxBuilder(),
          RadioButtonBuilder(),
          ToggleBuilder(),
          HeightSliderBuilder(),
          SliderBuilder(),
          SliderRangeBuilder(),
          LinkedTextBuilder(),
          TagBuilder(),
          ProgressBarBuilder(),
          SelectableButtonBuilder(),
          LogoBuilder(),
          IconBuilder(),
          // Molecules
          HeaderBuilder(),
          LabeledControlBuilder(),
          SelectionGroupBuilder(),
          SelectableButtonGroupBuilder(),
          SelectableTagGroupBuilder(),
          // Templates
          LandingScreenBuilder(),
        ];

  /// Get the build context (creates it lazily)
  BuilderContext get _context {
    return _buildContext ??= BuilderContext(
      formState: formState,
      buildChild: build,
      onApiAction: onApiAction,
      onExit: onExit,
    );
  }

  /// Build a widget from a ComponentConfig
  Widget build(ComponentConfig config) {
    // Optional validation
    if (validateBeforeBuild) {
      final errors = ComponentSpecRegistry.validate(config.type, config.props);
      if (errors.isNotEmpty) {
        return _buildValidationError(config.type, errors);
      }
    }

    // Find the appropriate builder
    for (final builder in _builders) {
      if (builder.supports(config.type)) {
        return builder.build(config, _context);
      }
    }

    // No builder found
    return _buildError('Unknown component type: ${config.type}');
  }

  /// Build children widgets from a list of configs
  List<Widget> buildChildren(List<ComponentConfig>? configs) {
    if (configs == null || configs.isEmpty) return [];
    return configs.map((config) => build(config)).toList();
  }

  /// Validate a component config without building
  List<String> validate(ComponentConfig config) {
    return ComponentSpecRegistry.validate(config.type, config.props);
  }

  /// Validate an entire tree of components
  Map<String, List<String>> validateTree(ComponentConfig root) {
    final errors = <String, List<String>>{};

    void validateRecursive(ComponentConfig config, String path) {
      final componentErrors = validate(config);
      if (componentErrors.isNotEmpty) {
        errors[path] = componentErrors;
      }

      if (config.children != null) {
        for (var i = 0; i < config.children!.length; i++) {
          validateRecursive(config.children![i], '$path.children[$i]');
        }
      }
    }

    validateRecursive(root, 'root');
    return errors;
  }

  /// Build an error widget
  Widget _buildError(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red.withValues(alpha: 0.1),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  /// Build a validation error widget
  Widget _buildValidationError(String type, List<String> errors) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.orange.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Validation errors for "$type":',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...errors.map(
            (e) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                '• $e',
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
