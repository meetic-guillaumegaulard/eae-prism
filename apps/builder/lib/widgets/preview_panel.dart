import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class PreviewPanel extends StatefulWidget {
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
  State<PreviewPanel> createState() => _PreviewPanelState();
}

class _PreviewPanelState extends State<PreviewPanel> {
  bool _isMobileMode = false;

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
              const Icon(Icons.preview, size: 16, color: Color(0xFF00E4D7)),
              const SizedBox(width: 8),
              const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              // View mode selector
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2D1B4E),
                  borderRadius: BorderRadius.circular(6),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildModeButton(
                      icon: Icons.aspect_ratio,
                      tooltip: 'Responsive',
                      isSelected: !_isMobileMode,
                      onTap: () => setState(() => _isMobileMode = false),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    _buildModeButton(
                      icon: Icons.smartphone,
                      tooltip: 'Mobile',
                      isSelected: _isMobileMode,
                      onTap: () => setState(() => _isMobileMode = true),
                    ),
                  ],
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
            color: const Color(0xFF150a25), // Darker background for canvas (0xFF201034 darkened)
            child: _isMobileMode
                ? Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        width: 390,
                        height: 844,
                        margin: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF201034),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.black,
                            width: 12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: _buildPreviewContent(),
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF201034),
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
                      child: _buildPreviewContent(),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeButton({
    required IconData icon,
    required String tooltip,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00E4D7).withValues(alpha: 0.2)
              : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isSelected ? const Color(0xFF00E4D7) : Colors.white54,
        ),
      ),
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
        widget.brand.name.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getBrandColor(),
        ),
      ),
    );
  }

  Color _getBrandColor() {
    switch (widget.brand) {
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

  Widget _buildPreviewContent() {
    if (widget.pageConfig == null) {
      return _buildEmptyPreview();
    }

    final screen = widget.pageConfig!['screen'] as Map<String, dynamic>?;
    if (screen == null) {
      return _buildEmptyPreview();
    }

    // Use the design system's DynamicScreen to render the preview
    try {
      final screenConfig = ScreenConfig.fromJson(screen);
      return Theme(
        data: BrandTheme.getTheme(widget.brand),
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
            'No content',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add components to see the preview',
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
              'Rendering Error',
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
