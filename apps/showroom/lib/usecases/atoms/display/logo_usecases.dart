import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class LogoUsecases extends StatelessWidget {
  const LogoUsecases({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Types de logos',
            'Trois types de logos sont disponibles: small (compact), onDark (pour fond sombre), onWhite (pour fond clair)',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Logo Small (compact)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LogoEAE.small(brand: Brand.match),
                      LogoEAE.small(brand: Brand.meetic),
                      LogoEAE.small(brand: Brand.okc),
                      LogoEAE.small(brand: Brand.pof),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Logo onWhite (fond clair)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LogoEAE.onWhite(brand: Brand.match),
                      LogoEAE.onWhite(brand: Brand.meetic),
                      LogoEAE.onWhite(brand: Brand.okc),
                      LogoEAE.onWhite(brand: Brand.pof),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Logo onDark (fond sombre)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LogoEAE.onDark(brand: Brand.match),
                      LogoEAE.onDark(brand: Brand.meetic),
                      LogoEAE.onDark(brand: Brand.okc),
                      LogoEAE.onDark(brand: Brand.pof),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Tailles personnalisées',
            'La hauteur du logo peut être ajustée, la largeur s\'adapte automatiquement',
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hauteur: 30px'),
                  SizedBox(height: 8),
                  LogoEAE.onWhite(brand: Brand.match, height: 30),
                  SizedBox(height: 16),
                  Text('Hauteur: 60px (défaut)'),
                  SizedBox(height: 8),
                  LogoEAE.onWhite(brand: Brand.match, height: 60),
                  SizedBox(height: 16),
                  Text('Hauteur: 100px'),
                  SizedBox(height: 8),
                  LogoEAE.onWhite(brand: Brand.match, height: 100),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Logos par marque avec le thème courant',
            'Le logo s\'adapte automatiquement au thème sélectionné',
            _buildCurrentBrandLogos(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Utilisation de l\'utilitaire ApiUtils',
            'ApiUtils permet de construire les URLs des assets',
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('URLs générées:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Small: ${ApiUtils.logoUrl('meetic', LogoType.small)}',
                      style: const TextStyle(
                          fontSize: 12, fontFamily: 'monospace')),
                  const SizedBox(height: 4),
                  Text('OnDark: ${ApiUtils.logoUrl('meetic', LogoType.onDark)}',
                      style: const TextStyle(
                          fontSize: 12, fontFamily: 'monospace')),
                  const SizedBox(height: 4),
                  Text(
                      'OnWhite: ${ApiUtils.logoUrl('meetic', LogoType.onWhite)}',
                      style: const TextStyle(
                          fontSize: 12, fontFamily: 'monospace')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBrandLogos(BuildContext context) {
    // Détecte la marque courante en utilisant les couleurs du thème
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    String brandName = 'Marque inconnue';
    Brand brand = Brand.match;

    // Match: #11144C, Meetic: #E9006D, OKC: #0046D5, POF: #000000
    if (primaryColor == const Color(0xFF11144C)) {
      brandName = 'Match';
      brand = Brand.match;
    } else if (primaryColor == const Color(0xFFE9006D)) {
      brandName = 'Meetic';
      brand = Brand.meetic;
    } else if (primaryColor == const Color(0xFF0046D5)) {
      brandName = 'OKCupid';
      brand = Brand.okc;
    } else if (primaryColor == const Color(0xFF000000)) {
      brandName = 'Plenty of Fish';
      brand = Brand.pof;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Thème actuel: $brandName',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  LogoEAE.small(brand: brand),
                  const SizedBox(height: 8),
                  const Text('Small', style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  LogoEAE.onWhite(brand: brand),
                  const SizedBox(height: 8),
                  const Text('OnWhite', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LogoEAE.onDark(brand: brand),
                  const SizedBox(height: 8),
                  const Text('OnDark',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String description, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }
}
