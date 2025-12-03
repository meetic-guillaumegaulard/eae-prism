import 'screen_config.dart';

/// Types de navigation supportés
enum NavigationType {
  /// Rafraîchit l'écran courant sans animation
  refresh,
  /// Navigation vers un nouvel écran avec animation
  navigate,
}

/// Direction de l'animation de transition
enum NavigationDirection {
  /// L'écran actuel part vers la gauche, le nouveau arrive de la droite
  left,
  /// L'écran actuel part vers la droite, le nouveau arrive de la gauche
  right,
  /// L'écran actuel part vers le haut, le nouveau arrive du bas
  up,
  /// L'écran actuel part vers le bas, le nouveau arrive du haut
  down,
}

/// Scope de l'animation
enum NavigationScope {
  /// Animation sur tout l'écran
  full,
  /// Animation uniquement sur le contenu, les bandeaux fixes restent en place
  content,
}

/// Configuration de la navigation retournée par le serveur
class NavigationConfig {
  /// Type de navigation
  final NavigationType type;

  /// Direction de la transition (uniquement pour navigate)
  final NavigationDirection direction;

  /// Scope de l'animation
  final NavigationScope scope;

  /// Durée de l'animation en millisecondes
  final int durationMs;

  const NavigationConfig({
    required this.type,
    this.direction = NavigationDirection.left,
    this.scope = NavigationScope.full,
    this.durationMs = 300,
  });

  factory NavigationConfig.fromJson(Map<String, dynamic> json) {
    return NavigationConfig(
      type: _parseNavigationType(json['type']),
      direction: _parseDirection(json['direction']),
      scope: _parseScope(json['scope']),
      durationMs: json['durationMs'] as int? ?? 300,
    );
  }

  static NavigationType _parseNavigationType(String? value) {
    return switch (value?.toLowerCase()) {
      'navigate' => NavigationType.navigate,
      _ => NavigationType.refresh,
    };
  }

  static NavigationDirection _parseDirection(String? value) {
    return switch (value?.toLowerCase()) {
      'right' => NavigationDirection.right,
      'up' => NavigationDirection.up,
      'down' => NavigationDirection.down,
      _ => NavigationDirection.left,
    };
  }

  static NavigationScope _parseScope(String? value) {
    return switch (value?.toLowerCase()) {
      'content' => NavigationScope.content,
      _ => NavigationScope.full,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'direction': direction.name,
      'scope': scope.name,
      'durationMs': durationMs,
    };
  }
}

/// Réponse complète de navigation du serveur
class NavigationResponse {
  /// Configuration de la navigation
  final NavigationConfig navigation;

  /// Configuration du nouvel écran
  final ScreenConfig screen;

  const NavigationResponse({
    required this.navigation,
    required this.screen,
  });

  factory NavigationResponse.fromJson(Map<String, dynamic> json) {
    return NavigationResponse(
      navigation: NavigationConfig.fromJson(
        json['navigation'] as Map<String, dynamic>? ?? {},
      ),
      screen: ScreenConfig.fromJson(
        json['screen'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'navigation': navigation.toJson(),
      'screen': screen.toJson(),
    };
  }
}

