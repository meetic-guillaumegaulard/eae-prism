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

  // You can change the brand here to test different themes
  const brand = Brand.match; // Try: match, meetic, okc, pof

  // Configure le backend URL pour le service de recommandation
  // Le backend gère l'appel à OpenAI (évite les problèmes CORS sur web)
  RecommendationService.initialize('http://localhost:3000');

  runApp(
    ProviderScope(
      child: MyApp(brand: brand),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Brand brand;
  static const String _baseUrl = 'http://localhost:3000/api';

  MyApp({super.key, required this.brand});

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => HomePage(brand: brand),
      ),
      // Route pour la page des intérêts avec recherche vocale
      GoRoute(
        path: '/interests',
        name: 'interests',
        builder: (context, state) => const InterestsPage(),
      ),
      // Route dynamique pour les écrans du flow
      GoRoute(
        path: '/dynamic-pages/:flowId/:screenId',
        name: 'dynamic-screen',
        pageBuilder: (context, state) {
          final flowId = state.pathParameters['flowId']!;
          final screenId = state.pathParameters['screenId']!;
          final extra = state.extra as Map<String, dynamic>?;

          // Utilise le builder du design_system avec les callbacks go_router
          return buildDynamicPage(
            screenId: '$flowId/$screenId',
            baseUrl: _baseUrl,
            extra: extra,
            onNavigate: (newScreenId, navExtra) {
              context.push('/dynamic-pages/$flowId/$newScreenId',
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
