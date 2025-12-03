import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

/// Widget stateful pour démontrer les usecases des icônes
class IconUsecases extends StatelessWidget {
  const IconUsecases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Tailles standardisées',
            _buildSizesDemo(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            'Constructeurs raccourcis',
            _buildShorthandDemo(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            'Couleurs',
            _buildColorsDemo(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            'Icônes courantes',
            _buildCommonIconsDemo(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            'Icône avec cercle',
            _buildCircleDemo(context),
          ),
          const SizedBox(height: 32),
          _buildSection(
            context,
            'Icône avec badge',
            _buildBadgeDemo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildSizesDemo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSizeItem(context, 'XS (16px)', IconSizeEAE.xs),
        _buildSizeItem(context, 'SM (20px)', IconSizeEAE.sm),
        _buildSizeItem(context, 'MD (24px)', IconSizeEAE.md),
        _buildSizeItem(context, 'LG (32px)', IconSizeEAE.lg),
        _buildSizeItem(context, 'XL (48px)', IconSizeEAE.xl),
      ],
    );
  }

  Widget _buildSizeItem(BuildContext context, String label, IconSizeEAE size) {
    return Column(
      children: [
        IconEAE(Icons.favorite, sizeEnum: size),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildShorthandDemo(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildIconWithLabel(context, const IconEAE.xs(Icons.star), 'IconEAE.xs'),
        _buildIconWithLabel(context, const IconEAE.sm(Icons.star), 'IconEAE.sm'),
        _buildIconWithLabel(context, const IconEAE.md(Icons.star), 'IconEAE.md'),
        _buildIconWithLabel(context, const IconEAE.lg(Icons.star), 'IconEAE.lg'),
        _buildIconWithLabel(context, const IconEAE.xl(Icons.star), 'IconEAE.xl'),
        _buildIconWithLabel(
          context,
          const IconEAE.custom(Icons.star, size: 36),
          'IconEAE.custom(36)',
        ),
      ],
    );
  }

  Widget _buildIconWithLabel(BuildContext context, Widget icon, String label) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildColorsDemo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        _buildColorItem(context, 'Primary', colorScheme.primary),
        _buildColorItem(context, 'Secondary', colorScheme.secondary),
        _buildColorItem(context, 'Error', colorScheme.error),
        _buildColorItem(context, 'Success', Colors.green),
        _buildColorItem(context, 'Warning', Colors.orange),
        _buildColorItem(context, 'Default', null),
      ],
    );
  }

  Widget _buildColorItem(BuildContext context, String label, Color? color) {
    return Column(
      children: [
        IconEAE(Icons.circle, sizeEnum: IconSizeEAE.lg, color: color),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildCommonIconsDemo(BuildContext context) {
    final icons = [
      (Icons.home, 'home'),
      (Icons.search, 'search'),
      (Icons.settings, 'settings'),
      (Icons.person, 'person'),
      (Icons.favorite, 'favorite'),
      (Icons.notifications, 'notifications'),
      (Icons.message, 'message'),
      (Icons.edit, 'edit'),
      (Icons.delete, 'delete'),
      (Icons.add, 'add'),
      (Icons.close, 'close'),
      (Icons.check, 'check'),
      (Icons.arrow_back, 'arrow_back'),
      (Icons.arrow_forward, 'arrow_forward'),
      (Icons.menu, 'menu'),
      (Icons.more_vert, 'more_vert'),
      (Icons.share, 'share'),
      (Icons.camera_alt, 'camera_alt'),
      (Icons.photo, 'photo'),
      (Icons.location_on, 'location_on'),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: icons.map((e) {
        return Tooltip(
          message: e.$2,
          child: IconEAE(e.$1, sizeEnum: IconSizeEAE.lg),
        );
      }).toList(),
    );
  }

  Widget _buildCircleDemo(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        Column(
          children: [
            IconCircleEAE(
              icon: Icons.person,
              iconSize: IconSizeEAE.md,
            ),
            const SizedBox(height: 8),
            Text('Default', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            IconCircleEAE(
              icon: Icons.check,
              iconSize: IconSizeEAE.lg,
              backgroundColor: Colors.green.shade100,
              iconColor: Colors.green,
            ),
            const SizedBox(height: 8),
            Text('Success', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            IconCircleEAE(
              icon: Icons.close,
              iconSize: IconSizeEAE.lg,
              backgroundColor: Colors.red.shade100,
              iconColor: Colors.red,
            ),
            const SizedBox(height: 8),
            Text('Error', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            IconCircleEAE(
              icon: Icons.info,
              iconSize: IconSizeEAE.lg,
              backgroundColor: Colors.blue.shade100,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 8),
            Text('Info', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }

  Widget _buildBadgeDemo(BuildContext context) {
    return Wrap(
      spacing: 32,
      runSpacing: 16,
      children: [
        Column(
          children: [
            const IconBadgeEAE(
              icon: Icons.notifications,
              iconSize: IconSizeEAE.lg,
            ),
            const SizedBox(height: 8),
            Text('Point', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            const IconBadgeEAE(
              icon: Icons.notifications,
              iconSize: IconSizeEAE.lg,
              badgeValue: 3,
            ),
            const SizedBox(height: 8),
            Text('Count: 3', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            const IconBadgeEAE(
              icon: Icons.message,
              iconSize: IconSizeEAE.lg,
              badgeValue: 42,
            ),
            const SizedBox(height: 8),
            Text('Count: 42', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            const IconBadgeEAE(
              icon: Icons.shopping_cart,
              iconSize: IconSizeEAE.lg,
              badgeValue: 150,
            ),
            const SizedBox(height: 8),
            Text('99+', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Column(
          children: [
            IconBadgeEAE(
              icon: Icons.mail,
              iconSize: IconSizeEAE.lg,
              badgeValue: 5,
              badgeColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text('Custom color', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

