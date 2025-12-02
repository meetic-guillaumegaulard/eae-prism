import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class TagUsecases extends StatefulWidget {
  const TagUsecases({Key? key}) : super(key: key);

  @override
  State<TagUsecases> createState() => _TagUsecasesState();
}

class _TagUsecasesState extends State<TagUsecases> {
  List<String> deletableTags = ['Tag 1', 'Tag 2', 'Tag 3', 'Tag 4'];

  // État pour les tags sélectionnables
  Set<String> selectedInterests = {
    '🎗️ Mental health awareness',
    'Sport',
    'Musique'
  };
  Set<String> selectedCategories = {'Technologie'};
  Set<String> selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Mode Lecture Seule',
            'Tags en lecture seule pour afficher de l\'information. Match: fond gris clair. Meetic: fond gris-bleu clair.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Style Match (avec émojis/icônes)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: '🏠 Home renovation shows',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: '🎬 Movies',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: '🎵 Music festivals',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: '⚽ Sports',
                      variant: TagEAEVariant.filled,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Style Meetic (avec émojis/icônes)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: '🎯 Fléchettes',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: '🎨 Art',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: '🍷 Oenologie',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: '🎭 Théâtre',
                      variant: TagEAEVariant.filled,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Style POF (fond blanc + bordure grise)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'I have kids',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Dog lover',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Adventurous',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Foodie',
                      variant: TagEAEVariant.filled,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Style OKC (similaire à POF)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Hiking',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Photography',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Coffee enthusiast',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Reader',
                      variant: TagEAEVariant.filled,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Filled',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Filled Tag',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'With Icon',
                      variant: TagEAEVariant.filled,
                      icon: Icons.star,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Mode Sélectionnable',
            'Tags cliquables qui peuvent être sélectionnés/désélectionnés. Sur Match/Meetic: fond beige + bordure brand.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Style Match/Meetic (avec émojis)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    '🎗️ Mental health awareness',
                    '🌱 Sustainability',
                    '📚 Lifelong learning',
                    '🎨 Creative expression'
                  ]
                      .map((interest) => TagEAE(
                            label: interest,
                            variant: TagEAEVariant.filled,
                            isSelected: selectedInterests.contains(interest),
                            onSelectedChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedInterests.add(interest);
                                } else {
                                  selectedInterests.remove(interest);
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text('Filled - Intérêts',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Sport', 'Musique', 'Voyage', 'Cuisine', 'Lecture']
                      .map((interest) => TagEAE(
                            label: interest,
                            variant: TagEAEVariant.filled,
                            isSelected: selectedInterests.contains(interest),
                            onSelectedChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedInterests.add(interest);
                                } else {
                                  selectedInterests.remove(interest);
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text('Filled - Catégories',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Technologie', 'Design', 'Marketing', 'Finance']
                      .map((category) => TagEAE(
                            label: category,
                            variant: TagEAEVariant.filled,
                            isSelected: selectedCategories.contains(category),
                            onSelectedChanged: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedCategories.add(category);
                                } else {
                                  selectedCategories.remove(category);
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Tailles',
            'Les tags sont disponibles en trois tailles',
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Small', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Small Tag',
                      size: TagEAESize.small,
                    ),
                    TagEAE(
                      label: 'With Icon',
                      size: TagEAESize.small,
                      icon: Icons.info,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Medium', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Medium Tag',
                      size: TagEAESize.medium,
                    ),
                    TagEAE(
                      label: 'With Icon',
                      size: TagEAESize.medium,
                      icon: Icons.info,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Large', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Large Tag',
                      size: TagEAESize.large,
                    ),
                    TagEAE(
                      label: 'With Icon',
                      size: TagEAESize.large,
                      icon: Icons.info,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Tags supprimables',
            'Les tags peuvent avoir un bouton de suppression',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: deletableTags
                      .map((tag) => TagEAE(
                            label: tag,
                            onDelete: () {
                              setState(() {
                                deletableTags.remove(tag);
                              });
                            },
                          ))
                      .toList(),
                ),
                if (deletableTags.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          deletableTags = ['Tag 1', 'Tag 2', 'Tag 3', 'Tag 4'];
                        });
                      },
                      child: const Text('Réinitialiser'),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Tags avec icônes',
            'Les tags peuvent afficher des icônes',
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TagEAE(
                  label: 'Favorite',
                  icon: Icons.favorite,
                  variant: TagEAEVariant.filled,
                ),
                TagEAE(
                  label: 'Star',
                  icon: Icons.star,
                  variant: TagEAEVariant.filled,
                ),
                TagEAE(
                  label: 'Award',
                  icon: Icons.emoji_events,
                  variant: TagEAEVariant.filled,
                ),
                TagEAE(
                  label: 'Trending',
                  icon: Icons.trending_up,
                  variant: TagEAEVariant.filled,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Couleurs personnalisées',
            'Les tags peuvent avoir des couleurs personnalisées',
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TagEAE(
                  label: 'Success',
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                TagEAE(
                  label: 'Warning',
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                TagEAE(
                  label: 'Error',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                TagEAE(
                  label: 'Info',
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                TagEAE(
                  label: 'Custom',
                  variant: TagEAEVariant.filled,
                  borderColor: Colors.purple,
                  foregroundColor: Colors.purple,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Tags sélectionnables avec icônes',
            'Combinaison de tags sélectionnables avec des icônes',
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TagEAE(
                  label: 'Favorite',
                  icon: Icons.favorite,
                  variant: TagEAEVariant.filled,
                  isSelected: selectedFilters.contains('Favorite'),
                  onSelectedChanged: (selected) {
                    setState(() {
                      if (selected) {
                        selectedFilters.add('Favorite');
                      } else {
                        selectedFilters.remove('Favorite');
                      }
                    });
                  },
                ),
                TagEAE(
                  label: 'Star',
                  icon: Icons.star,
                  variant: TagEAEVariant.filled,
                  isSelected: selectedFilters.contains('Star'),
                  onSelectedChanged: (selected) {
                    setState(() {
                      if (selected) {
                        selectedFilters.add('Star');
                      } else {
                        selectedFilters.remove('Star');
                      }
                    });
                  },
                ),
                TagEAE(
                  label: 'Trending',
                  icon: Icons.trending_up,
                  variant: TagEAEVariant.filled,
                  isSelected: selectedFilters.contains('Trending'),
                  onSelectedChanged: (selected) {
                    setState(() {
                      if (selected) {
                        selectedFilters.add('Trending');
                      } else {
                        selectedFilters.remove('Trending');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            'Cas d\'usage combinés',
            'Exemples de tags en lecture seule dans différents contextes',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Profil utilisateur',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Vérifié',
                      icon: Icons.verified,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      size: TagEAESize.small,
                    ),
                    TagEAE(
                      label: 'Premium',
                      icon: Icons.star,
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      size: TagEAESize.small,
                    ),
                    TagEAE(
                      label: 'Actif',
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      size: TagEAESize.small,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Catégories en lecture seule',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TagEAE(
                      label: 'Technologie',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Design',
                      variant: TagEAEVariant.filled,
                    ),
                    TagEAE(
                      label: 'Marketing',
                      variant: TagEAEVariant.filled,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
