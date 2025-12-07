import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';

class HomePage extends StatelessWidget {
  final Brand brand;
  final ValueChanged<Brand>? onBrandChanged;

  const HomePage({
    super.key,
    required this.brand,
    this.onBrandChanged,
  });

  /// Convertit Brand enum en string pour l'URL
  String get _brandSlug => switch (brand) {
        Brand.match => 'match',
        Brand.meetic => 'meetic',
        Brand.okc => 'okc',
        Brand.pof => 'pof',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BrandTheme.getBrandName(brand)),
        actions: [
          // Sélecteur de brand
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton<Brand>(
              value: brand,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: onBrandChanged != null
                  ? (newBrand) {
                      if (newBrand != null) {
                        onBrandChanged!(newBrand);
                      }
                    }
                  : null,
              items: Brand.values.map((b) {
                return DropdownMenuItem<Brand>(
                  value: b,
                  child: Text(BrandTheme.getBrandName(b)),
                );
              }).toList(),
            ),
          ),
        ],
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
                  context
                      .push('/dynamic-pages/$_brandSlug/profile-capture/start');
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
