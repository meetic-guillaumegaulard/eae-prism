import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class _AllTextTypesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display
          TextEAE(
            'Display Large',
            type: TextTypeEAE.displayLarge,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Display Medium',
            type: TextTypeEAE.displayMedium,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Display Small',
            type: TextTypeEAE.displaySmall,
          ),
          SizedBox(height: 32),
          Divider(),
          SizedBox(height: 32),

          // Headlines
          TextEAE(
            'Headline Large (H1)',
            type: TextTypeEAE.headlineLarge,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Headline Medium (H2)',
            type: TextTypeEAE.headlineMedium,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Headline Small (H3)',
            type: TextTypeEAE.headlineSmall,
          ),
          SizedBox(height: 32),
          Divider(),
          SizedBox(height: 32),

          // Titles
          TextEAE(
            'Title Large (H4)',
            type: TextTypeEAE.titleLarge,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Title Medium (H5)',
            type: TextTypeEAE.titleMedium,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Title Small (H6)',
            type: TextTypeEAE.titleSmall,
          ),
          SizedBox(height: 32),
          Divider(),
          SizedBox(height: 32),

          // Body
          TextEAE(
            'Body Large - Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            type: TextTypeEAE.bodyLarge,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Body Medium - Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            type: TextTypeEAE.bodyMedium,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Body Small - Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            type: TextTypeEAE.bodySmall,
          ),
          SizedBox(height: 32),
          Divider(),
          SizedBox(height: 32),

          // Labels
          TextEAE(
            'Label Large',
            type: TextTypeEAE.labelLarge,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Label Medium',
            type: TextTypeEAE.labelMedium,
          ),
          SizedBox(height: 16),
          TextEAE(
            'Label Small',
            type: TextTypeEAE.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _ShorthandConstructorsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextEAE.h1('Titre H1 avec constructeur raccourci'),
          SizedBox(height: 16),
          TextEAE.h2('Titre H2 avec constructeur raccourci'),
          SizedBox(height: 16),
          TextEAE.h3('Titre H3 avec constructeur raccourci'),
          SizedBox(height: 16),
          TextEAE.h4('Titre H4 avec constructeur raccourci'),
          SizedBox(height: 16),
          TextEAE.h5('Titre H5 avec constructeur raccourci'),
          SizedBox(height: 16),
          TextEAE.h6('Titre H6 avec constructeur raccourci'),
          SizedBox(height: 32),
          Divider(),
          SizedBox(height: 32),
          TextEAE.body(
            'Paragraphe normal avec le constructeur .body(). Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 16),
          TextEAE.small(
            'Petit texte avec le constructeur .small(). Texte secondaire ou notes.',
          ),
          SizedBox(height: 16),
          TextEAE.label('Label avec le constructeur .label()'),
        ],
      ),
    );
  }
}

class _CustomizationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextEAE.h2('Personnalisation des textes'),
          const SizedBox(height: 24),

          // Couleurs
          const TextEAE.h3('Couleurs personnalisées'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Texte en rouge',
            color: Colors.red,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte en bleu',
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          TextEAE.body(
            'Texte en vert',
            color: Colors.green.shade700,
          ),
          const SizedBox(height: 32),

          // Font weights
          const TextEAE.h3('Épaisseurs de police'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Texte normal',
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte en gras',
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte extra gras',
            fontWeight: FontWeight.w900,
          ),
          const SizedBox(height: 32),

          // Alignements
          const TextEAE.h3('Alignements de texte'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Texte aligné à gauche (défaut)',
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte centré',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte aligné à droite',
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 32),

          // Décorations
          const TextEAE.h3('Décorations'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Texte souligné',
            decoration: TextDecoration.underline,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte barré',
            decoration: TextDecoration.lineThrough,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte en italique',
            fontStyle: FontStyle.italic,
          ),
          const SizedBox(height: 32),

          // Tailles personnalisées
          const TextEAE.h3('Tailles de police personnalisées'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Texte 12px',
            fontSize: 12,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte 16px',
            fontSize: 16,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte 20px',
            fontSize: 20,
          ),
          const SizedBox(height: 8),
          const TextEAE.body(
            'Texte 24px',
            fontSize: 24,
          ),
        ],
      ),
    );
  }
}

class _OverflowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextEAE.h2('Gestion du débordement de texte'),
          const SizedBox(height: 24),
          const TextEAE.h3('Texte avec maxLines'),
          const SizedBox(height: 16),
          Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextEAE.small('1 ligne max avec ellipsis:'),
                SizedBox(height: 8),
                TextEAE.body(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                TextEAE.small('2 lignes max avec ellipsis:'),
                SizedBox(height: 8),
                TextEAE.body(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 16),
                TextEAE.small('Fade overflow:'),
                SizedBox(height: 8),
                TextEAE.body(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RealWorldExampleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card exemple
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextEAE.h3('Titre de la carte'),
                  const SizedBox(height: 8),
                  TextEAE.small(
                    'Publié le 2 décembre 2025',
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 16),
                  const TextEAE.body(
                    'Voici un exemple d\'utilisation réel du composant TextEAE dans une carte. '
                    'On peut facilement combiner différents types de textes pour créer une mise en page cohérente.',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextEAE.label('EN SAVOIR PLUS'),
                      TextEAE.label(
                        '5 min de lecture',
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Profil exemple
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: TextEAE(
                        'JD',
                        type: TextTypeEAE.titleMedium,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextEAE.h4('Jean Dupont'),
                        const SizedBox(height: 4),
                        TextEAE.body(
                          'Développeur Flutter',
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(height: 4),
                        TextEAE.small(
                          'Paris, France',
                          color: Colors.grey.shade500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Article exemple
          const TextEAE.h1('Introduction à Flutter'),
          const SizedBox(height: 8),
          TextEAE.small(
            'Par l\'équipe Design System • 15 min de lecture',
            color: Colors.grey.shade600,
          ),
          const SizedBox(height: 24),
          const TextEAE.h2('Qu\'est-ce que Flutter?'),
          const SizedBox(height: 12),
          const TextEAE.body(
            'Flutter est un framework open-source développé par Google pour créer des applications natives '
            'pour mobile, web et desktop à partir d\'une seule base de code.',
          ),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Il utilise le langage Dart et offre un système de widgets riche et personnalisable.',
          ),
          const SizedBox(height: 24),
          const TextEAE.h3('Les avantages de Flutter'),
          const SizedBox(height: 12),
          const TextEAE.body('• Performance native'),
          const SizedBox(height: 8),
          const TextEAE.body('• Hot reload pour un développement rapide'),
          const SizedBox(height: 8),
          const TextEAE.body('• UI cohérente sur toutes les plateformes'),
        ],
      ),
    );
  }
}

Widget buildAllTextTypes(BuildContext context) {
  return _AllTextTypesDemo();
}

Widget buildShorthandConstructors(BuildContext context) {
  return _ShorthandConstructorsDemo();
}

Widget buildTextCustomization(BuildContext context) {
  return _CustomizationDemo();
}

Widget buildTextOverflow(BuildContext context) {
  return _OverflowDemo();
}

Widget buildRealWorldExample(BuildContext context) {
  return _RealWorldExampleDemo();
}

class _TypographyComparisonDemo extends StatelessWidget {
  Widget _buildConfigRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Color(0xFF11144C)),
                      const SizedBox(width: 8),
                      TextEAE.h4(
                        'Typographie - Toutes les brands',
                        color: Colors.blue.shade900,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildConfigRow('Police', 'Lora (serif)'),
                        const SizedBox(height: 4),
                        _buildConfigRow('Poids', 'Semi-Bold (600)'),
                        const SizedBox(height: 4),
                        _buildConfigRow('Couleur', '#11144C (Bleu Match)'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextEAE.body(
                    'Match & Meetic : Lora Semi-Bold (élégant)\n'
                    'OKC : Montserrat Bold (moderne)\n'
                    'POF : DM Serif Display (moderne serif)',
                    color: Colors.blue.shade900,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Exemple de page d'onboarding (adapté selon la brand)
          const TextEAE.h1(
            'Verify Your Account',
          ),
          const SizedBox(height: 16),
          const TextEAE.h2(
            'Check Your Email',
          ),
          const SizedBox(height: 8),
          const TextEAE.h3(
            'Enter the Code',
          ),
          const SizedBox(height: 24),
          const TextEAE.body(
            'Cette phrase utilise la police par défaut pour le corps du texte.',
          ),
          const SizedBox(height: 48),

          // Autres exemples de titres
          const TextEAE.h2('Create your profile'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Share your photos and tell us about yourself to find the perfect match.',
          ),
          const SizedBox(height: 32),

          const TextEAE.h3('What are your interests?'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Select your hobbies and interests to help us find compatible matches.',
          ),
          const SizedBox(height: 32),

          // Card exemple avec typographie mixte
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextEAE.h3('Ready to start?'),
                  const SizedBox(height: 12),
                  const TextEAE.body(
                    'Join thousands of singles who have found their perfect match. '
                    'Your journey to finding love starts here.',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Get Started'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Démonstration de tous les niveaux de titres
          const Divider(),
          const SizedBox(height: 32),
          const TextEAE.h4('Hiérarchie typographique'),
          const SizedBox(height: 16),
          const TextEAE.h1('Titre H1 - Lora sur Match'),
          const SizedBox(height: 8),
          const TextEAE.h2('Titre H2 - Lora sur Match'),
          const SizedBox(height: 8),
          const TextEAE.h3('Titre H3 - Lora sur Match'),
          const SizedBox(height: 8),
          const TextEAE.h4('Titre H4 - Lora sur Match'),
          const SizedBox(height: 8),
          const TextEAE.h5('Titre H5 - Lora sur Match'),
          const SizedBox(height: 8),
          const TextEAE.h6('Titre H6 - Lora sur Match'),
          const SizedBox(height: 16),
          const TextEAE.body(
            'Corps de texte normal - Police système',
          ),
        ],
      ),
    );
  }
}

Widget buildTypographyComparison(BuildContext context) {
  return _TypographyComparisonDemo();
}
