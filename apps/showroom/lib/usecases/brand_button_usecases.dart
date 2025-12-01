import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

Widget buildPrimaryButton(BuildContext context) {
  return Center(
    child: BrandButton(
      label: 'Primary Button',
      onPressed: () {},
      variant: BrandButtonVariant.primary,
    ),
  );
}

Widget buildSecondaryButton(BuildContext context) {
  return Center(
    child: BrandButton(
      label: 'Secondary Button',
      onPressed: () {},
      variant: BrandButtonVariant.secondary,
    ),
  );
}

Widget buildOutlineButton(BuildContext context) {
  return Center(
    child: BrandButton(
      label: 'Outline Button',
      onPressed: () {},
      variant: BrandButtonVariant.outline,
    ),
  );
}

Widget buildButtonWithIcon(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BrandButton(
          label: 'Like',
          icon: Icons.favorite,
          onPressed: () {},
          variant: BrandButtonVariant.primary,
        ),
        const SizedBox(height: 16),
        BrandButton(
          label: 'Send Message',
          icon: Icons.send,
          onPressed: () {},
          variant: BrandButtonVariant.secondary,
        ),
        const SizedBox(height: 16),
        BrandButton(
          label: 'Share',
          icon: Icons.share,
          onPressed: () {},
          variant: BrandButtonVariant.outline,
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
        BrandButton(
          label: 'Small Button',
          size: BrandButtonSize.small,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        BrandButton(
          label: 'Medium Button',
          size: BrandButtonSize.medium,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        BrandButton(
          label: 'Large Button',
          size: BrandButtonSize.large,
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
        BrandButton(
          label: 'Loading...',
          isLoading: true,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        BrandButton(
          label: 'Normal Button',
          isLoading: false,
          onPressed: () {},
        ),
      ],
    ),
  );
}

