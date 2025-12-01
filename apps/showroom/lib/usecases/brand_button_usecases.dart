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
