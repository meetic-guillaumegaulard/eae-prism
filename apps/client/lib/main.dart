import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'screens/home_page.dart';
import 'screens/dynamic_page.dart';

void main() {
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
        builder: (context, state) {
          final screenId = state.pathParameters['screenId']!;
          // Récupère la config et les form values depuis extra si disponibles
          final extra = state.extra as Map<String, dynamic>?;

          // La config peut être soit un ScreenConfig, soit un Map (après sérialisation)
          ScreenConfig? config;
          final rawConfig = extra?['config'];
          if (rawConfig is ScreenConfig) {
            config = rawConfig;
          } else if (rawConfig is Map) {
            // Convertir le Map en Map<String, dynamic> si nécessaire
            config =
                ScreenConfig.fromJson(Map<String, dynamic>.from(rawConfig));
          }

          // Pareil pour formValues
          Map<String, dynamic>? formValues;
          final rawFormValues = extra?['formValues'];
          if (rawFormValues is Map) {
            formValues = Map<String, dynamic>.from(rawFormValues);
          }

          return DynamicPage(
            brand: brand,
            screenId: screenId,
            config: config,
            initialValues: formValues,
          );
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
