import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system/design_system.dart';
import 'screens/home/home_page.dart';
import 'screens/interests/interests_page.dart';
import 'screens/interests/services/recommendation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Active la synchronisation de l'URL avec push() (pas seulement go())
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Configure le backend URL pour le service de recommandation
  // Le backend gère l'appel à OpenAI (évite les problèmes CORS sur web)
  RecommendationService.initialize('http://localhost:3000');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _baseUrl = 'http://localhost:3000/api';

  // Brand par défaut
  Brand _currentBrand = Brand.match;

  void _changeBrand(Brand newBrand) {
    setState(() {
      _currentBrand = newBrand;
    });
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => HomePage(
            brand: _currentBrand,
            onBrandChanged: _changeBrand,
          ),
        ),
        // Route pour la page des intérêts avec recherche vocale
        GoRoute(
          path: '/interests',
          name: 'interests',
          builder: (context, state) => const InterestsPage(),
        ),
        // Route dynamique pour les écrans du flow (avec brand)
        GoRoute(
          path: '/dynamic-pages/:brand/:flowId/:screenId',
          name: 'dynamic-screen',
          pageBuilder: (context, state) {
            final brand = state.pathParameters['brand']!;
            final flowId = state.pathParameters['flowId']!;
            final screenId = state.pathParameters['screenId']!;
            final extra = state.extra as Map<String, dynamic>?;

            // Utilise le builder du design_system avec les callbacks go_router
            return buildDynamicPage(
              screenId: '$brand/$flowId/$screenId',
              baseUrl: _baseUrl,
              extra: extra,
              onNavigate: (newScreenId, navExtra) {
                context.push('/dynamic-pages/$brand/$flowId/$newScreenId',
                    extra: navExtra);
              },
              onBack: () => context.pop(),
              onGoHome: () => context.go('/'),
              canPop: () => context.canPop(),
              onExit: (destination, values) {
                // Navigation vers des écrans statiques selon la destination
                debugPrint('Exit flow: $destination with values: $values');
                switch (destination) {
                  case 'submit':
                    // Retour à l'accueil après soumission
                    context.go('/');
                    break;
                  default:
                    // Navigation par défaut vers une route nommée
                    context.go('/$destination');
                }
              },
            ).toPage(state.pageKey);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Recréer le router à chaque build pour prendre en compte la brand courante
    final router = _buildRouter();

    return MaterialApp.router(
      // Key basée sur la brand pour forcer la reconstruction complète
      key: ValueKey(_currentBrand),
      title: BrandTheme.getBrandName(_currentBrand),
      theme: BrandTheme.getTheme(_currentBrand),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
