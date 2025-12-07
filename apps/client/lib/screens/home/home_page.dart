import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';

class HomePage extends StatelessWidget {
  final Brand brand;

  const HomePage({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BrandTheme.getBrandName(brand)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenue sur ${BrandTheme.getBrandName(brand)}',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.push('/dynamic-pages/profile-capture/step1');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                ),
                child: const Text('Commencer'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  context.push('/interests');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                icon: const Icon(Icons.mic, size: 18),
                label: const Text('Recherche vocale'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
