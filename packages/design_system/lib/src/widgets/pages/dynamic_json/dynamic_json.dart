/// Dynamic JSON screen builder module
///
/// This module provides tools to build Flutter screens dynamically from JSON configuration.
///
/// ## Architecture
///
/// Components are organized by category with co-located files:
/// ```
/// widgets/
/// ├── atoms/
/// │   └── button/
/// │       ├── button_eae.dart        # Widget
/// │       ├── button_eae_builder.dart # JSON builder
/// │       └── button_eae_spec.dart   # Validation spec
/// ├── molecules/
/// │   └── header/
/// │       ├── header_eae.dart
/// │       ├── header_eae_builder.dart
/// │       └── header_eae_spec.dart
/// └── templates/
///     └── landing_screen/
///         ├── landing_screen_eae.dart
///         ├── landing_screen_eae_builder.dart
///         └── landing_screen_eae_spec.dart
/// ```
///
/// ## Usage
///
/// ```dart
/// // Initialize specs at app startup (optional, for validation)
/// initializeComponentSpecs();
///
/// // Create the factory
/// final factory = ComponentFactory(
///   formState: FormStateManager(),
///   actions: {'submit': () => print('Submitted!')},
///   validateBeforeBuild: true, // Enable validation
/// );
///
/// // Build from JSON
/// final config = ComponentConfig.fromJson(jsonData);
/// final widget = factory.build(config);
/// ```
///
/// La navigation est gérée par le parent via le callback [onNavigate] de DynamicScreen.
library dynamic_json;

// Core
export 'component_config.dart';
export 'screen_config.dart';
export 'component_factory.dart';
export 'form_state_manager.dart';
export 'dynamic_screen.dart';
export 'navigation_response.dart';
export 'full_page_transition.dart';
export 'dynamic_page_builder.dart';
export 'dynamic_page.dart';

// Shared utilities
export 'shared/shared.dart';
