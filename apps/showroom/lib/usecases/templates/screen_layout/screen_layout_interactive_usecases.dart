import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

enum ScreenLayoutExample {
  shortContent,
  longContent,
  headerOnly,
  footerOnly,
  noHeaderFooter,
  formExample,
}

class ScreenLayoutInteractiveUsecases extends StatefulWidget {
  const ScreenLayoutInteractiveUsecases({Key? key}) : super(key: key);

  @override
  State<ScreenLayoutInteractiveUsecases> createState() =>
      _ScreenLayoutInteractiveUsecasesState();
}

class _ScreenLayoutInteractiveUsecasesState
    extends State<ScreenLayoutInteractiveUsecases> {
  ScreenLayoutExample _selectedExample = ScreenLayoutExample.longContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildExampleSelector(context),
            Expanded(
              child: _buildSelectedExample(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleSelector(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Screen Layout - Test interactif',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildExampleChip(
                context,
                'Contenu court',
                ScreenLayoutExample.shortContent,
              ),
              _buildExampleChip(
                context,
                'Contenu long',
                ScreenLayoutExample.longContent,
              ),
              _buildExampleChip(
                context,
                'Header seul',
                ScreenLayoutExample.headerOnly,
              ),
              _buildExampleChip(
                context,
                'Footer seul',
                ScreenLayoutExample.footerOnly,
              ),
              _buildExampleChip(
                context,
                'Sans header/footer',
                ScreenLayoutExample.noHeaderFooter,
              ),
              _buildExampleChip(
                context,
                'Formulaire',
                ScreenLayoutExample.formExample,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExampleChip(
    BuildContext context,
    String label,
    ScreenLayoutExample example,
  ) {
    final isSelected = _selectedExample == example;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedExample = example;
        });
      },
      backgroundColor: isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).colorScheme.surface,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Theme.of(context).primaryColor,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      selectedColor: Theme.of(context).primaryColor,
      showCheckmark: false,
    );
  }

  Widget _buildSelectedExample() {
    switch (_selectedExample) {
      case ScreenLayoutExample.shortContent:
        return ScreenLayoutEAE(
          topBar: _buildTopBar(context, 'Header'),
          bottomBar: _buildBottomBar(context),
          content: _buildShortContent(),
        );
      case ScreenLayoutExample.longContent:
        return ScreenLayoutEAE(
          topBar: _buildTopBar(context, 'Header'),
          bottomBar: _buildBottomBar(context),
          content: _buildLongContent(),
        );
      case ScreenLayoutExample.headerOnly:
        return ScreenLayoutEAE(
          topBar: _buildTopBar(context, 'Header Only'),
          content: _buildLongContent(),
        );
      case ScreenLayoutExample.footerOnly:
        return ScreenLayoutEAE(
          bottomBar: _buildBottomBar(context),
          content: _buildLongContent(),
        );
      case ScreenLayoutExample.noHeaderFooter:
        return ScreenLayoutEAE(
          content: _buildLongContent(),
        );
      case ScreenLayoutExample.formExample:
        return ScreenLayoutEAE(
          topBar: _buildFormHeader(context),
          bottomBar: _buildFormFooter(context),
          content: _buildFormContent(context),
        );
    }
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
