import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'screens/home_page.dart';
import 'screens/dynamic_page.dart';

void main() {
  // Active la synchronisation de l'URL avec push() (pas seulement go())
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // You can change the brand here to test different themes
  const brand = Brand.match; // Try: match, meetic, okc, pof

  runApp(MyApp(brand: brand));
}

class MyApp extends StatelessWidget {
  final Brand brand;

  MyApp({super.key, required this.brand});

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomePage(brand: brand),
      ),
      // Route dynamique pour les écrans du flow
      GoRoute(
        path: '/screens/:screenId',
        name: 'dynamic-screen',
        pageBuilder: (context, state) {
          final screenId = state.pathParameters['screenId']!;
          final extra = state.extra as Map<String, dynamic>?;

          // La config peut être soit un ScreenConfig, soit un Map
          ScreenConfig? config;
          final rawConfig = extra?['config'];
          if (rawConfig is ScreenConfig) {
            config = rawConfig;
          } else if (rawConfig is Map) {
            config =
                ScreenConfig.fromJson(Map<String, dynamic>.from(rawConfig));
          }

          // FormValues
          Map<String, dynamic>? formValues;
          final rawFormValues = extra?['formValues'];
          if (rawFormValues is Map) {
            formValues = Map<String, dynamic>.from(rawFormValues);
          }

          // Direction de l'animation (depuis la réponse serveur)
          final direction = extra?['direction'] as String? ?? 'left';
          final durationMs = extra?['durationMs'] as int? ?? 300;

          final child = DynamicPage(
            brand: brand,
            screenId: screenId,
            config: config,
            initialValues: formValues,
          );

          return CustomTransitionPage(
            key: state.pageKey,
            child: child,
            transitionDuration: Duration(milliseconds: durationMs),
            reverseTransitionDuration: Duration(milliseconds: durationMs),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return _buildTransition(
                  direction, animation, secondaryAnimation, child);
            },
          );
        },
      ),
    ],
  );

  /// Construit la transition selon la direction
  static Widget _buildTransition(
    String direction,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Offset de départ selon la direction
    final Offset beginOffset = switch (direction) {
      'left' => const Offset(1.0, 0.0),
      'right' => const Offset(-1.0, 0.0),
      'up' => const Offset(0.0, 1.0),
      'down' => const Offset(0.0, -1.0),
      _ => const Offset(1.0, 0.0),
    };

    final offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    ));

    // Animation de sortie de l'écran précédent
    final exitOffset = switch (direction) {
      'left' => const Offset(-0.3, 0.0),
      'right' => const Offset(0.3, 0.0),
      'up' => const Offset(0.0, -0.3),
      'down' => const Offset(0.0, 0.3),
      _ => const Offset(-0.3, 0.0),
    };

    final secondaryOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeOutCubic,
    ));

    return SlideTransition(
      position: secondaryOffsetAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: BrandTheme.getBrandName(brand),
      theme: BrandTheme.getTheme(brand),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
