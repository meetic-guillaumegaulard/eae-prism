import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class LandingScreenUsecases extends StatelessWidget {
  const LandingScreenUsecases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LandingScreenDemo();
  }
}

class _LandingScreenDemo extends StatelessWidget {
  const _LandingScreenDemo();

  static const String _baseUrl = 'http://localhost:3000/api/assets';

  @override
  Widget build(BuildContext context) {
    return LandingScreenEAE(
      config: LandingScreenConfig(
        backgroundImageMobile: const NetworkImage(
          '$_baseUrl/brands/okc/landing-mobile.jpg',
        ),
        backgroundImageDesktop: const NetworkImage(
          '$_baseUrl/brands/okc/landing-desktop.jpg',
        ),
        logoLarge: _buildLogoPlaceholder(context, isLarge: true),
        logoSmall: _buildLogoPlaceholder(context, isLarge: false),
        topBarButtonText: 'Se connecter',
        onTopBarButtonPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bouton "Se connecter" pressé')),
          );
        },
      ),
      content: _buildContent(context),
      bottomBar: _buildBottomBar(context),
    );
  }

  Widget _buildLogoPlaceholder(BuildContext context, {required bool isLarge}) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 24 : 12,
        vertical: isLarge ? 12 : 6,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isLarge ? 'BRAND LOGO' : 'LOGO',
        style: TextStyle(
          color: Colors.white,
          fontSize: isLarge ? 24 : 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TextEAE(
          'Bienvenue',
          type: TextTypeEAE.headlineLarge,
        ),
        const SizedBox(height: 8),
        const TextEAE(
          'Créez votre compte pour commencer',
          type: TextTypeEAE.bodyLarge,
        ),
        const SizedBox(height: 24),
        const TextInputEAE(
          label: 'Email',
          hintText: 'Entrez votre email',
        ),
        const SizedBox(height: 16),
        const TextInputEAE(
          label: 'Mot de passe',
          hintText: 'Entrez votre mot de passe',
          obscureText: true,
        ),
        const SizedBox(height: 24),
        ButtonEAE(
          label: "S'inscrire",
          isFullWidth: true,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Inscription...')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ButtonEAE(
            label: 'Créer un compte',
            isFullWidth: true,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Créer un compte...')),
              );
            },
          ),
          const SizedBox(height: 16),
          const LinkedTextEAE(
            htmlText: 'Déjà un compte ? <a href="#">Se connecter</a>',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Version avec image de fond personnalisée
class LandingScreenWithBackgroundDemo extends StatelessWidget {
  const LandingScreenWithBackgroundDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fond dégradé simulant une image
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor.withOpacity(0.3),
                  primaryColor.withOpacity(0.1),
                ],
              ),
            ),
          ),
          LandingScreenEAE(
            config: LandingScreenConfig(
              logoLarge: _buildLogoWidget(context, isLarge: true),
              logoSmall: _buildLogoWidget(context, isLarge: false),
              topBarButtonText: 'Se connecter',
              onTopBarButtonPressed: () {},
            ),
            content: _buildSimpleContent(context),
            bottomBar: _buildSimpleBottomBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoWidget(BuildContext context, {required bool isLarge}) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 32 : 16,
        vertical: isLarge ? 16 : 8,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isLarge ? 'MY APP' : 'APP',
        style: TextStyle(
          color: Colors.white,
          fontSize: isLarge ? 32 : 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildSimpleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TextEAE(
          'Trouvez votre match',
          type: TextTypeEAE.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const TextEAE(
          'Des millions de personnes vous attendent',
          type: TextTypeEAE.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ButtonEAE(
          label: 'Commencer',
          isFullWidth: true,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSimpleBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ButtonEAE(
            label: 'Continuer avec Apple',
            variant: ButtonEAEVariant.outline,
            isFullWidth: true,
            icon: Icons.apple,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          ButtonEAE(
            label: 'Continuer avec Google',
            variant: ButtonEAEVariant.outline,
            isFullWidth: true,
            icon: Icons.g_mobiledata,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          const LinkedTextEAE(
            htmlText:
                'En continuant, vous acceptez nos <a href="#">Conditions</a> et notre <a href="#">Politique de confidentialité</a>',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
