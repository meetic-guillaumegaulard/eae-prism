/// Dynamic JSON screen builder module
///
/// This module provides tools to build Flutter screens dynamically from JSON configuration.
/// 
/// La navigation est gérée par le parent via le callback [onNavigate] de DynamicScreen.
/// Utilisez simplement Navigator.push pour naviguer vers un nouvel écran.
library dynamic_json;

export 'component_config.dart';
export 'screen_config.dart';
export 'component_factory.dart';
export 'form_state_manager.dart';
export 'dynamic_screen.dart';
export 'navigation_response.dart';
