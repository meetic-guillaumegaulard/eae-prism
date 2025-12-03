import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' hide ExitCallback;
import '../../templates/screen_layout/screen_layout_eae.dart';
import 'screen_config.dart';
import 'full_page_transition.dart';
import 'dynamic_page.dart';
import 'shared/builder_context.dart' show ExitCallback;

/// Configuration de page retournée par le builder
class DynamicPageBuildResult {
  /// Widget enfant à afficher
  final Widget child;

  /// Durée de la transition
  final Duration transitionDuration;

  /// Direction de la transition
  final TransitionDirection direction;

  /// Si true, anime toute la page (sinon juste le contenu)
  final bool animateFullPage;

  const DynamicPageBuildResult({
    required this.child,
    required this.transitionDuration,
    required this.direction,
    required this.animateFullPage,
  });

  /// Crée le transitionsBuilder pour les transitions de page
  Widget buildTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
  }) {
    if (animateFullPage) {
      return ScreenTransitionScope(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        direction: direction,
        animateFullPage: true,
        child: FullPageTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          direction: direction,
          child: child,
        ),
      );
    }
    return ScreenTransitionScope(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      direction: direction,
      child: child,
    );
  }

  /// Crée la CustomTransitionPage pour go_router
  CustomTransitionPage<void> toPage(LocalKey pageKey) {
    return CustomTransitionPage(
      key: pageKey,
      child: child,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return buildTransition(
          context: context,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
    );
  }
}

/// Construit le résultat complet pour une page dynamique
DynamicPageBuildResult buildDynamicPage({
  required String screenId,
  required String baseUrl,
  required NavigateCallback onNavigate,
  required BackCallback onBack,
  required GoHomeCallback onGoHome,
  required CanPopCallback canPop,
  ExitCallback? onExit,
  Map<String, dynamic>? extra,
}) {
  // Parse la config et les form values depuis les extras
  final config = parseScreenConfig(extra);
  final formValues = parseFormValues(extra);

  // Crée le widget enfant
  final child = DynamicPage(
    screenId: screenId,
    config: config,
    initialValues: formValues,
    baseUrl: baseUrl,
    onNavigate: onNavigate,
    onBack: onBack,
    onGoHome: onGoHome,
    canPop: canPop,
    onExit: onExit,
  );

  // Parse les paramètres de transition
  final direction = extra?['direction'] as String? ?? 'left';
  final durationMs = extra?['durationMs'] as int? ?? 300;
  final scope = extra?['scope'] as String? ?? 'full';
  final animateFullPage = scope == 'full';

  // Convertit la direction string en enum
  final transitionDirection = switch (direction) {
    'left' => TransitionDirection.left,
    'right' => TransitionDirection.right,
    'up' => TransitionDirection.up,
    'down' => TransitionDirection.down,
    _ => TransitionDirection.left,
  };

  return DynamicPageBuildResult(
    child: child,
    transitionDuration: Duration(milliseconds: durationMs),
    direction: transitionDirection,
    animateFullPage: animateFullPage,
  );
}

/// Parse la config d'écran depuis les extras
ScreenConfig? parseScreenConfig(Map<String, dynamic>? extra) {
  final rawConfig = extra?['config'];
  if (rawConfig is ScreenConfig) {
    return rawConfig;
  } else if (rawConfig is Map) {
    return ScreenConfig.fromJson(Map<String, dynamic>.from(rawConfig));
  }
  return null;
}

/// Parse les form values depuis les extras
Map<String, dynamic>? parseFormValues(Map<String, dynamic>? extra) {
  final rawFormValues = extra?['formValues'];
  if (rawFormValues is Map) {
    return Map<String, dynamic>.from(rawFormValues);
  }
  return null;
}
