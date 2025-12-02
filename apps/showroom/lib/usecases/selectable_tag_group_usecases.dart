import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

/// Use cases for the SelectableTagGroupEAE component
class SelectableTagGroupUseCases extends StatelessWidget {
  const SelectableTagGroupUseCases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildHeader('Selectable Tag Group', 'Groupes de tags sélectionnables'),
        const SizedBox(height: 32),
        _buildUseCase('Basic - Multi-groups', _BasicMultiGroupsExample()),
        const SizedBox(height: 40),
        _buildUseCase('With Max Selection', _MaxSelectionExample()),
        const SizedBox(height: 40),
        _buildUseCase('Different Sizes', _DifferentSizesExample()),
        const SizedBox(height: 40),
        _buildUseCase('With Initial Selection', _InitialSelectionExample()),
        const SizedBox(height: 40),
        _buildUseCase(
            'Custom Colors - Match Brand', _CustomColorsMatchExample()),
        const SizedBox(height: 40),
        _buildUseCase(
            'Custom Colors - Meetic Brand', _CustomColorsMeeticExample()),
        const SizedBox(height: 40),
        _buildUseCase(
            'Real-world Example: Interests', _RealWorldInterestsExample()),
      ],
    );
  }

  Widget _buildHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildUseCase(String title, Widget example) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        example,
      ],
    );
  }
}

class _BasicMultiGroupsExample extends StatefulWidget {
  const _BasicMultiGroupsExample();

  @override
  State<_BasicMultiGroupsExample> createState() =>
      _BasicMultiGroupsExampleState();
}

class _BasicMultiGroupsExampleState extends State<_BasicMultiGroupsExample> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableTagGroupEAE<String>(
          groups: [
            TagGroup(
              title: 'Activités sportives',
              options: [
                const TagOption(label: 'Football', value: 'football'),
                const TagOption(label: 'Basketball', value: 'basketball'),
                const TagOption(label: 'Tennis', value: 'tennis'),
                const TagOption(label: 'Natation', value: 'natation'),
                const TagOption(label: 'Course à pied', value: 'running'),
              ],
            ),
            TagGroup(
              title: 'Activités culturelles',
              options: [
                const TagOption(label: 'Cinéma', value: 'cinema'),
                const TagOption(label: 'Musique', value: 'music'),
                const TagOption(label: 'Lecture', value: 'reading'),
                const TagOption(label: 'Théâtre', value: 'theatre'),
                const TagOption(label: 'Musées', value: 'museums'),
              ],
            ),
            TagGroup(
              title: 'Cuisine',
              options: [
                const TagOption(label: 'Italienne', value: 'italian'),
                const TagOption(label: 'Japonaise', value: 'japanese'),
                const TagOption(label: 'Française', value: 'french'),
                const TagOption(label: 'Mexicaine', value: 'mexican'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedValues = values;
            });
          },
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Sélection: ${selectedValues.isEmpty ? "Aucune" : selectedValues.join(", ")}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _MaxSelectionExample extends StatefulWidget {
  const _MaxSelectionExample();

  @override
  State<_MaxSelectionExample> createState() => _MaxSelectionExampleState();
}

class _MaxSelectionExampleState extends State<_MaxSelectionExample> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Maximum 3 sélections (${selectedValues.length}/3)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[900],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SelectableTagGroupEAE<String>(
          maxSelections: 3,
          groups: [
            TagGroup(
              title: 'Langues parlées',
              options: [
                const TagOption(label: 'Français', value: 'fr'),
                const TagOption(label: 'Anglais', value: 'en'),
                const TagOption(label: 'Espagnol', value: 'es'),
                const TagOption(label: 'Italien', value: 'it'),
                const TagOption(label: 'Allemand', value: 'de'),
                const TagOption(label: 'Portugais', value: 'pt'),
                const TagOption(label: 'Chinois', value: 'zh'),
                const TagOption(label: 'Japonais', value: 'ja'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedValues = values;
            });
          },
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Sélection: ${selectedValues.isEmpty ? "Aucune" : selectedValues.join(", ")}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _DifferentSizesExample extends StatefulWidget {
  const _DifferentSizesExample();

  @override
  State<_DifferentSizesExample> createState() => _DifferentSizesExampleState();
}

class _DifferentSizesExampleState extends State<_DifferentSizesExample> {
  List<String> selectedSmall = [];
  List<String> selectedMedium = [];
  List<String> selectedLarge = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Small', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SelectableTagGroupEAE<String>(
          tagSize: TagEAESize.small,
          groups: [
            TagGroup(
              title: '',
              options: [
                const TagOption(label: 'Tag 1', value: '1'),
                const TagOption(label: 'Tag 2', value: '2'),
                const TagOption(label: 'Tag 3', value: '3'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedSmall = values;
            });
          },
        ),
        const SizedBox(height: 24),
        const Text('Medium (default)',
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SelectableTagGroupEAE<String>(
          tagSize: TagEAESize.medium,
          groups: [
            TagGroup(
              title: '',
              options: [
                const TagOption(label: 'Tag 1', value: '1'),
                const TagOption(label: 'Tag 2', value: '2'),
                const TagOption(label: 'Tag 3', value: '3'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedMedium = values;
            });
          },
        ),
        const SizedBox(height: 24),
        const Text('Large', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        SelectableTagGroupEAE<String>(
          tagSize: TagEAESize.large,
          groups: [
            TagGroup(
              title: '',
              options: [
                const TagOption(label: 'Tag 1', value: '1'),
                const TagOption(label: 'Tag 2', value: '2'),
                const TagOption(label: 'Tag 3', value: '3'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedLarge = values;
            });
          },
        ),
      ],
    );
  }
}

class _InitialSelectionExample extends StatefulWidget {
  const _InitialSelectionExample();

  @override
  State<_InitialSelectionExample> createState() =>
      _InitialSelectionExampleState();
}

class _InitialSelectionExampleState extends State<_InitialSelectionExample> {
  List<String> selectedValues = ['tennis', 'music', 'italian'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Tags pré-sélectionnés: Tennis, Musique, Italienne',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SelectableTagGroupEAE<String>(
          initialSelectedValues: selectedValues,
          groups: [
            TagGroup(
              title: 'Activités',
              options: [
                const TagOption(label: 'Football', value: 'football'),
                const TagOption(label: 'Tennis', value: 'tennis'),
                const TagOption(label: 'Natation', value: 'natation'),
              ],
            ),
            TagGroup(
              title: 'Loisirs',
              options: [
                const TagOption(label: 'Cinéma', value: 'cinema'),
                const TagOption(label: 'Musique', value: 'music'),
                const TagOption(label: 'Lecture', value: 'reading'),
              ],
            ),
            TagGroup(
              title: 'Cuisine',
              options: [
                const TagOption(label: 'Italienne', value: 'italian'),
                const TagOption(label: 'Japonaise', value: 'japanese'),
                const TagOption(label: 'Française', value: 'french'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedValues = values;
            });
          },
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Sélection actuelle: ${selectedValues.isEmpty ? "Aucune" : selectedValues.join(", ")}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _CustomColorsMatchExample extends StatefulWidget {
  const _CustomColorsMatchExample();

  @override
  State<_CustomColorsMatchExample> createState() =>
      _CustomColorsMatchExampleState();
}

class _CustomColorsMatchExampleState extends State<_CustomColorsMatchExample> {
  List<String> selectedValues = [];
  final Color matchBlue = const Color(0xFF11144C);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableTagGroupEAE<String>(
          tagVariant: TagEAEVariant.filled,
          selectedBackgroundColor: matchBlue,
          selectedForegroundColor: Colors.white,
          selectedBorderColor: matchBlue,
          unselectedBorderColor: Colors.grey[400],
          unselectedForegroundColor: Colors.grey[700],
          groups: [
            TagGroup(
              title: 'Vos intérêts (Match)',
              options: [
                const TagOption(label: 'Sport', value: 'sport'),
                const TagOption(label: 'Voyage', value: 'travel'),
                const TagOption(label: 'Gastronomie', value: 'food'),
                const TagOption(label: 'Art', value: 'art'),
                const TagOption(label: 'Technologie', value: 'tech'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedValues = values;
            });
          },
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: matchBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Sélection: ${selectedValues.isEmpty ? "Aucune" : selectedValues.join(", ")}',
            style: TextStyle(fontSize: 14, color: matchBlue),
          ),
        ),
      ],
    );
  }
}

class _CustomColorsMeeticExample extends StatefulWidget {
  const _CustomColorsMeeticExample();

  @override
  State<_CustomColorsMeeticExample> createState() =>
      _CustomColorsMeeticExampleState();
}

class _CustomColorsMeeticExampleState
    extends State<_CustomColorsMeeticExample> {
  List<String> selectedValues = [];
  final Color meeticPurple = const Color(0xFF2B0A3D);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableTagGroupEAE<String>(
          tagVariant: TagEAEVariant.filled,
          selectedBackgroundColor: meeticPurple,
          selectedForegroundColor: Colors.white,
          unselectedBackgroundColor: Colors.grey[200],
          unselectedForegroundColor: Colors.grey[700],
          groups: [
            TagGroup(
              title: 'Vos passions (Meetic)',
              options: [
                const TagOption(label: 'Randonnée', value: 'hiking'),
                const TagOption(label: 'Photographie', value: 'photo'),
                const TagOption(label: 'Jardinage', value: 'garden'),
                const TagOption(label: 'Yoga', value: 'yoga'),
                const TagOption(label: 'Cuisine', value: 'cooking'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedValues = values;
            });
          },
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: meeticPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Sélection: ${selectedValues.isEmpty ? "Aucune" : selectedValues.join(", ")}',
            style: TextStyle(fontSize: 14, color: meeticPurple),
          ),
        ),
      ],
    );
  }
}

class _RealWorldInterestsExample extends StatefulWidget {
  const _RealWorldInterestsExample();

  @override
  State<_RealWorldInterestsExample> createState() =>
      _RealWorldInterestsExampleState();
}

class _RealWorldInterestsExampleState
    extends State<_RealWorldInterestsExample> {
  List<String> selectedValues = ['travel', 'movies', 'cooking'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🎯 Complétez votre profil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sélectionnez jusqu\'à 5 centres d\'intérêt pour vous aider à trouver des personnes compatibles',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SelectableTagGroupEAE<String>(
          maxSelections: 5,
          initialSelectedValues: selectedValues,
          tagVariant: TagEAEVariant.filled,
          groups: [
            TagGroup(
              title: '🏃 Sports & Activités',
              options: [
                const TagOption(label: 'Fitness', value: 'fitness'),
                const TagOption(label: 'Course à pied', value: 'running'),
                const TagOption(label: 'Yoga', value: 'yoga'),
                const TagOption(label: 'Natation', value: 'swimming'),
                const TagOption(label: 'Vélo', value: 'cycling'),
                const TagOption(label: 'Randonnée', value: 'hiking'),
              ],
            ),
            TagGroup(
              title: '🎨 Culture & Arts',
              options: [
                const TagOption(label: 'Cinéma', value: 'movies'),
                const TagOption(label: 'Musique', value: 'music'),
                const TagOption(label: 'Peinture', value: 'painting'),
                const TagOption(label: 'Photographie', value: 'photography'),
                const TagOption(label: 'Théâtre', value: 'theatre'),
                const TagOption(label: 'Lecture', value: 'reading'),
              ],
            ),
            TagGroup(
              title: '🌍 Lifestyle',
              options: [
                const TagOption(label: 'Voyage', value: 'travel'),
                const TagOption(label: 'Cuisine', value: 'cooking'),
                const TagOption(label: 'Gastronomie', value: 'gastronomy'),
                const TagOption(label: 'Vin', value: 'wine'),
                const TagOption(label: 'Jardinage', value: 'gardening'),
                const TagOption(label: 'Mode', value: 'fashion'),
              ],
            ),
            TagGroup(
              title: '🎮 Loisirs',
              options: [
                const TagOption(label: 'Jeux vidéo', value: 'gaming'),
                const TagOption(label: 'Jeux de société', value: 'boardgames'),
                const TagOption(label: 'Danse', value: 'dancing'),
                const TagOption(label: 'Animaux', value: 'animals'),
                const TagOption(label: 'Technologie', value: 'tech'),
              ],
            ),
          ],
          onSelectionChanged: (values) {
            setState(() {
              selectedValues = values;
            });
          },
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${selectedValues.length}/5 intérêts sélectionnés',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedValues.join(' • '),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
