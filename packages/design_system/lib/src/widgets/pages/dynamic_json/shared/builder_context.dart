import 'package:flutter/material.dart';
import '../component_config.dart';
import '../form_state_manager.dart';

/// Callback pour les actions d'appel API
typedef ApiActionCallback = void Function(String endpoint);

/// Callback appelé quand l'utilisateur veut sortir du flow dynamique
/// [destination] identifie où l'utilisateur veut aller (ex: 'submit', 'skip', 'profile', 'back')
/// [values] contient les valeurs courantes du formulaire
typedef ExitCallback = void Function(
  String destination,
  Map<String, dynamic> values,
);

/// Context passed to all builders
class BuilderContext {
  /// Form state manager to automatically collect values
  final FormStateManager formState;

  /// Callback pour les appels API
  final ApiActionCallback? onApiAction;

  /// Callback appelé quand un composant a une propriété "exit"
  /// Reçoit la destination (valeur de exit) et les valeurs du formulaire
  final ExitCallback? onExit;

  /// Function to recursively build children
  final Widget Function(ComponentConfig config) buildChild;

  const BuilderContext({
    required this.formState,
    required this.buildChild,
    this.onApiAction,
    this.onExit,
  });

  /// Build children widgets from a list of configs
  List<Widget> buildChildren(List<ComponentConfig>? configs) {
    if (configs == null || configs.isEmpty) return [];
    return configs.map((config) => buildChild(config)).toList();
  }
}

/// Base class for component builders
abstract class ComponentBuilder {
  /// List of component types this builder handles
  List<String> get supportedTypes;

  /// Build a widget from config
  Widget build(ComponentConfig config, BuilderContext context);

  /// Check if this builder supports a type
  bool supports(String type) => supportedTypes.contains(type.toLowerCase());
}

