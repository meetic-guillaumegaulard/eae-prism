import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

Widget buildPrimaryButton(BuildContext context) {
  return Center(
    child: ButtonEAE(
      label: 'Primary Button',
      onPressed: () {},
      variant: ButtonEAEVariant.primary,
    ),
  );
}

Widget buildSecondaryButton(BuildContext context) {
  return Center(
    child: ButtonEAE(
      label: 'Secondary Button',
      onPressed: () {},
      variant: ButtonEAEVariant.secondary,
    ),
  );
}

Widget buildOutlineButton(BuildContext context) {
  return Center(
    child: ButtonEAE(
      label: 'Outline Button',
      onPressed: () {},
      variant: ButtonEAEVariant.outline,
    ),
  );
}

Widget buildButtonWithIcon(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonEAE(
          label: 'Like',
          icon: Icons.favorite,
          onPressed: () {},
          variant: ButtonEAEVariant.primary,
        ),
        const SizedBox(height: 16),
        ButtonEAE(
          label: 'Send Message',
          icon: Icons.send,
          onPressed: () {},
          variant: ButtonEAEVariant.secondary,
        ),
        const SizedBox(height: 16),
        ButtonEAE(
          label: 'Share',
          icon: Icons.share,
          onPressed: () {},
          variant: ButtonEAEVariant.outline,
        ),
      ],
    ),
  );
}

Widget buildButtonSizes(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonEAE(
          label: 'Small Button',
          size: ButtonEAESize.small,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        ButtonEAE(
          label: 'Medium Button',
          size: ButtonEAESize.medium,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        ButtonEAE(
          label: 'Large Button',
          size: ButtonEAESize.large,
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget buildLoadingButton(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonEAE(
          label: 'Loading...',
          isLoading: true,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        ButtonEAE(
          label: 'Normal Button',
          isLoading: false,
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget buildButtonWidthBehavior(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fit Content (Auto width):',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              ButtonEAE(
                label: 'OK',
                onPressed: () {},
                size: ButtonEAESize.small,
              ),
              ButtonEAE(
                label: 'Validate',
                onPressed: () {},
                size: ButtonEAESize.small,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ButtonEAE(
            label: 'This button adapts to its long text content',
            onPressed: () {},
          ),
          const SizedBox(height: 32),
          const Text('Full Width:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ButtonEAE(
            label: 'I take all available width',
            isFullWidth: true,
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

Widget buildDisabledButton(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonEAE(
          label: 'Disabled Button',
          onPressed: null, // Setting onPressed to null disables the button
          variant: ButtonEAEVariant.primary,
        ),
        const SizedBox(height: 16),
        ButtonEAE(
          label: 'Enabled for comparison',
          onPressed: () {},
          variant: ButtonEAEVariant.primary,
        ),
      ],
    ),
  );
}
