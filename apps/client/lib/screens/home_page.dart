import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class HomePage extends StatefulWidget {
  final Brand brand;

  const HomePage({super.key, required this.brand});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _isLoading = false;

  void _incrementCounter() {
    setState(() {
      _isLoading = true;
    });

    // Simulate async operation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _counter++;
        _isLoading = false;
      });
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandName = BrandTheme.getBrandName(widget.brand);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to $brandName!',
                        style: theme.textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This is a multi-brand Flutter app with a shared design system.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Counter Display
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Counter Value',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_counter',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontSize: 48,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Button Showcase
                Text(
                  'Button Variants',
                  style: theme.textTheme.displayMedium?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 16),

                // Primary Button with loading state
                ButtonEAE(
                  label: _isLoading ? 'Loading...' : 'Increment Counter',
                  icon: Icons.add,
                  onPressed: _isLoading ? null : _incrementCounter,
                  isLoading: _isLoading,
                  variant: ButtonEAEVariant.primary,
                  size: ButtonEAESize.large,
                  isFullWidth: true,
                ),
                const SizedBox(height: 16),

                // Secondary Button
                ButtonEAE(
                  label: 'Reset Counter',
                  icon: Icons.refresh,
                  onPressed: _resetCounter,
                  variant: ButtonEAEVariant.secondary,
                  size: ButtonEAESize.medium,
                  isFullWidth: true,
                ),
                const SizedBox(height: 16),

                // Outline Button
                ButtonEAE(
                  label: 'Send Message',
                  icon: Icons.send,
                  onPressed: () => _showMessage('Message sent!'),
                  variant: ButtonEAEVariant.outline,
                  size: ButtonEAESize.medium,
                  isFullWidth: true,
                ),
                const SizedBox(height: 32),

                // Size Variants
                Text(
                  'Button Sizes',
                  style: theme.textTheme.displayMedium?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ButtonEAE(
                        label: 'Small',
                        onPressed: () => _showMessage('Small button clicked'),
                        size: ButtonEAESize.small,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ButtonEAE(
                        label: 'Medium',
                        onPressed: () => _showMessage('Medium button clicked'),
                        size: ButtonEAESize.medium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ButtonEAE(
                        label: 'Large',
                        onPressed: () => _showMessage('Large button clicked'),
                        size: ButtonEAESize.large,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Icon Buttons
                Text(
                  'Icon Buttons',
                  style: theme.textTheme.displayMedium?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ButtonEAE(
                        label: 'Like',
                        icon: Icons.favorite,
                        onPressed: () => _showMessage('Liked!'),
                        variant: ButtonEAEVariant.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ButtonEAE(
                        label: 'Share',
                        icon: Icons.share,
                        onPressed: () => _showMessage('Shared!'),
                        variant: ButtonEAEVariant.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Brand Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Brand: $brandName',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'To switch brands, change the Brand enum in main.dart',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Available brands: Match, Meetic, OKCupid, Plenty of Fish',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
