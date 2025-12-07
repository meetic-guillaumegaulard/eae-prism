import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class PreviewPanel extends StatelessWidget {
  final Map<String, dynamic>? pageConfig;
  final Brand brand;
  final String? selectedPath;
  final void Function(String?) onSelect;

  const PreviewPanel({
    super.key,
    this.pageConfig,
    required this.brand,
    this.selectedPath,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.preview, size: 16, color: Color(0xFF6C63FF)),
              const SizedBox(width: 8),
              const Text(
                'Aperçu',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              _buildBrandBadge(),
            ],
          ),
        ),
        // Preview content
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildPreview(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getBrandColor().withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _getBrandColor().withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        brand.name.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getBrandColor(),
        ),
      ),
    );
  }

  Color _getBrandColor() {
    switch (brand) {
      case Brand.match:
        return const Color(0xFF11144C);
      case Brand.meetic:
        return const Color(0xFF9D4EDD);
      case Brand.okc:
        return const Color(0xFF0046D5);
      case Brand.pof:
        return const Color(0xFF333333);
    }
  }

  Widget _buildPreview() {
    if (pageConfig == null) {
      return _buildEmptyPreview();
    }

    final screen = pageConfig!['screen'] as Map<String, dynamic>?;
    if (screen == null) {
      return _buildEmptyPreview();
    }

    // Use the design system's DynamicScreen to render the preview
    try {
      final screenConfig = ScreenConfig.fromJson(screen);
      return Theme(
        data: BrandTheme.getTheme(brand),
        child: DynamicScreen(
          config: screenConfig,
          onFormChanged: (_) {},
          onNavigate: (_, __) {},
          onBack: () {},
        ),
      );
    } catch (e) {
      return _buildErrorPreview(e.toString());
    }
  }

  Widget _buildEmptyPreview() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.smartphone,
            size: 64,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun contenu',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ajoutez des composants pour voir l\'aperçu',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPreview(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Erreur de rendu',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

