import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class ScreenLayoutUsecases extends StatelessWidget {
  const ScreenLayoutUsecases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Layout'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildUsecaseCard(
            context,
            title: 'Avec header et footer - Contenu court',
            description:
                'Layout avec header et footer fixes. Contenu court non-scrollable. Les lignes de séparation et dégradés ne devraient pas apparaître.',
            child: SizedBox(
              height: 400,
              child: ScreenLayoutEAE(
                topBar: _buildTopBar(context, 'Header'),
                bottomBar: _buildBottomBar(context),
                content: _buildShortContent(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildUsecaseCard(
            context,
            title: 'Avec header et footer - Contenu long',
            description:
                'Layout avec header et footer fixes. Contenu scrollable. Les lignes de séparation apparaissent. Les dégradés indiquent la possibilité de scroller.',
            child: SizedBox(
              height: 400,
              child: ScreenLayoutEAE(
                topBar: _buildTopBar(context, 'Header'),
                bottomBar: _buildBottomBar(context),
                content: _buildLongContent(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildUsecaseCard(
            context,
            title: 'Avec header uniquement',
            description:
                'Layout avec header fixe uniquement. Contenu scrollable. Ligne de séparation et dégradé en haut seulement.',
            child: SizedBox(
              height: 400,
              child: ScreenLayoutEAE(
                topBar: _buildTopBar(context, 'Header Only'),
                content: _buildLongContent(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildUsecaseCard(
            context,
            title: 'Avec footer uniquement',
            description:
                'Layout avec footer fixe uniquement. Contenu scrollable. Ligne de séparation et dégradé en bas seulement.',
            child: SizedBox(
              height: 400,
              child: ScreenLayoutEAE(
                bottomBar: _buildBottomBar(context),
                content: _buildLongContent(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildUsecaseCard(
            context,
            title: 'Sans header ni footer',
            description:
                'Layout sans header ni footer. Contenu scrollable uniquement. Pas de lignes ni de dégradés.',
            child: SizedBox(
              height: 400,
              child: ScreenLayoutEAE(
                content: _buildLongContent(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildUsecaseCard(
            context,
            title: 'Exemple avec formulaire',
            description:
                'Exemple pratique : formulaire avec titre en haut et boutons en bas.',
            child: SizedBox(
              height: 500,
              child: ScreenLayoutEAE(
                topBar: _buildFormHeader(context),
                bottomBar: _buildFormFooter(context),
                content: _buildFormContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsecaseCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      child: Row(
        children: [
          Icon(Icons.menu, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomBarItem(context, Icons.home, 'Home'),
          _buildBottomBarItem(context, Icons.search, 'Search'),
          _buildBottomBarItem(context, Icons.favorite, 'Likes'),
          _buildBottomBarItem(context, Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem(
      BuildContext context, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildShortContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            color: Colors.blue[100],
            alignment: Alignment.center,
            child: const Text('Contenu court'),
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            color: Colors.green[100],
            alignment: Alignment.center,
            child: const Text('Pas besoin de scroll'),
          ),
        ],
      ),
    );
  }

  Widget _buildLongContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          20,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length]
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Élément scrollable ${index + 1}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Créer votre profil',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Remplissez les informations ci-dessous',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Continuer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: Text(
              'Passer cette étape',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField('Prénom', Icons.person_outline),
          const SizedBox(height: 20),
          _buildFormField('Nom', Icons.person_outline),
          const SizedBox(height: 20),
          _buildFormField('Email', Icons.email_outlined),
          const SizedBox(height: 20),
          _buildFormField('Téléphone', Icons.phone_outlined),
          const SizedBox(height: 20),
          _buildFormField('Ville', Icons.location_on_outlined),
          const SizedBox(height: 20),
          _buildFormField('Code postal', Icons.markunread_mailbox_outlined),
          const SizedBox(height: 20),
          const Text(
            'À propos de vous',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Text(
              'Parlez-nous de vous, de vos passions, de ce que vous recherchez...\n\nCe champ peut contenir plusieurs lignes de texte.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey[600], size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Saisir $label',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
