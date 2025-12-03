import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'dynamic_page.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DynamicPage(brand: brand),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: const Text('Commencer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
