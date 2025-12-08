import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class LandingScreenUsecases extends StatelessWidget {
  const LandingScreenUsecases({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LandingScreenDemo();
  }
}

class _LandingScreenDemo extends StatelessWidget {
  const _LandingScreenDemo();

  /// Détecte la brand courante en fonction du thème
  Brand _detectBrand(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Match: #11144C, Meetic: #E9006D, OKC: #0046D5, POF: #000000
    if (primaryColor == const Color(0xFF11144C)) return Brand.match;
    if (primaryColor == const Color(0xFFE9006D)) return Brand.meetic;
    if (primaryColor == const Color(0xFF0046D5)) return Brand.okc;
    if (primaryColor == const Color(0xFF000000)) return Brand.pof;

    return Brand.match; // default
  }

  /// Retourne le nom de la brand pour l'URL des assets
  String _getBrandName(Brand brand) {
    return switch (brand) {
      Brand.match => 'match',
      Brand.meetic => 'meetic',
      Brand.okc => 'okc',
      Brand.pof => 'pof',
    };
  }

  @override
  Widget build(BuildContext context) {
    final brand = _detectBrand(context);
    final brandName = _getBrandName(brand);

    return LandingScreenEAE(
      config: LandingScreenConfig(
        brand: brand,
        backgroundImageMobile: NetworkImage(
          ApiUtils.landingMobileBackgroundUrl(brandName),
        ),
        backgroundImageDesktop: NetworkImage(
          ApiUtils.landingDesktopBackgroundUrl(brandName),
        ),
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
  const LandingScreenWithBackgroundDemo({super.key});

  /// Détecte la brand courante en fonction du thème
  Brand _detectBrand(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Match: #11144C, Meetic: #E9006D, OKC: #0046D5, POF: #000000
    if (primaryColor == const Color(0xFF11144C)) return Brand.match;
    if (primaryColor == const Color(0xFFE9006D)) return Brand.meetic;
    if (primaryColor == const Color(0xFF0046D5)) return Brand.okc;
    if (primaryColor == const Color(0xFF000000)) return Brand.pof;

    return Brand.match; // default
  }

  @override
  Widget build(BuildContext context) {
    final brand = _detectBrand(context);
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
                  primaryColor.withValues(alpha: 0.3),
                  primaryColor.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
          LandingScreenEAE(
            config: LandingScreenConfig(
              brand: brand,
              mobileLogoType: LogoTypeEAE.onWhite, // Fond clair ici
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
