import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class ProgressBarUsecases extends StatefulWidget {
  const ProgressBarUsecases({super.key});

  @override
  State<ProgressBarUsecases> createState() => _ProgressBarUsecasesState();
}

class _ProgressBarUsecasesState extends State<ProgressBarUsecases> {
  int _progress1 = 3;
  int _progress2 = 7;
  int _progress3 = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Bar Use Cases'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Basic Progress Bars
            _buildSectionTitle('Basic Progress Bars'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Progress with Counter (3/5)',
              child: Column(
                children: [
                  ProgressBarEAE(
                    min: 1,
                    max: 5,
                    value: _progress1,
                    showCounter: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _progress1 > 1
                            ? () {
                                setState(() {
                                  _progress1--;
                                });
                              }
                            : null,
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$_progress1 / 5',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _progress1 < 5
                            ? () {
                                setState(() {
                                  _progress1++;
                                });
                              }
                            : null,
                        child: const Text('+'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Progress without Counter',
              child: Column(
                children: [
                  ProgressBarEAE(
                    min: 1,
                    max: 10,
                    value: _progress2,
                    showCounter: false,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _progress2 > 1
                            ? () {
                                setState(() {
                                  _progress2--;
                                });
                              }
                            : null,
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Step $_progress2 of 10',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _progress2 < 10
                            ? () {
                                setState(() {
                                  _progress2++;
                                });
                              }
                            : null,
                        child: const Text('+'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Section: Different Ranges
            _buildSectionTitle('Different Min/Max Ranges'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Range 0-100',
              child: const ProgressBarEAE(
                min: 0,
                max: 100,
                value: 35,
                showCounter: true,
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Range 1-3',
              child: Column(
                children: [
                  ProgressBarEAE(
                    min: 1,
                    max: 3,
                    value: _progress3,
                    showCounter: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _progress3 > 1
                            ? () {
                                setState(() {
                                  _progress3--;
                                });
                              }
                            : null,
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Page $_progress3 of 3',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _progress3 < 3
                            ? () {
                                setState(() {
                                  _progress3++;
                                });
                              }
                            : null,
                        child: const Text('+'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Range 10-50',
              child: const ProgressBarEAE(
                min: 10,
                max: 50,
                value: 30,
                showCounter: true,
              ),
            ),
            const SizedBox(height: 32),

            // Section: Different States
            _buildSectionTitle('Different Progress States'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Just Started (0%)',
              child: const ProgressBarEAE(
                min: 0,
                max: 10,
                value: 0,
                showCounter: true,
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Half Way (50%)',
              child: const ProgressBarEAE(
                min: 0,
                max: 10,
                value: 5,
                showCounter: true,
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Almost Done (90%)',
              child: const ProgressBarEAE(
                min: 0,
                max: 10,
                value: 9,
                showCounter: true,
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Completed (100%)',
              child: const ProgressBarEAE(
                min: 0,
                max: 10,
                value: 10,
                showCounter: true,
              ),
            ),
            const SizedBox(height: 32),

            // Section: Gradient Example
            _buildSectionTitle('Gradient Example'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Match Gradient (Theme-based)',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Match brand uses a gradient with transparent background'),
                  SizedBox(height: 16),
                  ProgressBarEAE(
                    min: 0,
                    max: 10,
                    value: 6,
                    showCounter: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Custom Gradient',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Custom blue to purple gradient'),
                  const SizedBox(height: 16),
                  ProgressBarEAE(
                    min: 0,
                    max: 10,
                    value: 7,
                    activeGradient: const LinearGradient(
                      colors: [
                        Color(0xFF4A90E2),
                        Color(0xFF9013FE),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    inactiveColor: Colors.grey.shade200,
                    showCounter: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Section: Border Radius Customization
            _buildSectionTitle('Border Radius Options'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Default (Theme-based)',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Uses brand configuration (Match/Meetic: 0, OKC/POF: 4)'),
                  SizedBox(height: 16),
                  ProgressBarEAE(
                    min: 0,
                    max: 10,
                    value: 6,
                    showCounter: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Sharp Corners (borderRadius: 0)',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No rounded corners'),
                  SizedBox(height: 16),
                  ProgressBarEAE(
                    min: 0,
                    max: 10,
                    value: 6,
                    showCounter: true,
                    borderRadius: 0.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Rounded Corners (borderRadius: 8)',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('More rounded appearance'),
                  SizedBox(height: 16),
                  ProgressBarEAE(
                    min: 0,
                    max: 10,
                    value: 6,
                    showCounter: true,
                    borderRadius: 8.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Fully Rounded (borderRadius: 999)',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Capsule shape'),
                  SizedBox(height: 16),
                  ProgressBarEAE(
                    min: 0,
                    max: 10,
                    value: 6,
                    showCounter: true,
                    borderRadius: 999.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Section: Real-world Examples
            _buildSectionTitle('Real-world Use Cases'),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Profile Completion',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete your profile',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text('Add more details to increase your match rate'),
                  const SizedBox(height: 16),
                  const ProgressBarEAE(
                    min: 0,
                    max: 5,
                    value: 3,
                    showCounter: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Onboarding Steps',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Getting Started',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text('Complete the setup to start using the app'),
                  const SizedBox(height: 16),
                  const ProgressBarEAE(
                    min: 1,
                    max: 4,
                    value: 2,
                    showCounter: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: 'Survey Progress',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us about yourself',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'Answer a few questions to personalize your experience'),
                  const SizedBox(height: 16),
                  const ProgressBarEAE(
                    min: 1,
                    max: 10,
                    value: 6,
                    showCounter: false,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '6 of 10 questions answered',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
