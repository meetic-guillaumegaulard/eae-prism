import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:design_system/design_system.dart';

/// Usecases pour le composant HeaderEAE
WidgetbookComponent buildHeaderUsecases() {
  return WidgetbookComponent(
    name: 'HeaderEAE',
    useCases: [
      WidgetbookUseCase(
        name: 'Default (with back button)',
        builder: (context) => Container(
          color: const Color(0xFF2C2C2C), // Fond sombre pour voir le header
          child: HeaderEAE(
            icon: context.knobs.list(
              label: 'Icon',
              options: [
                Icons.calendar_today,
                Icons.person,
                Icons.location_on,
                Icons.favorite,
                Icons.email,
                Icons.phone,
              ],
              labelBuilder: (icon) {
                if (icon == Icons.calendar_today) return 'Calendar';
                if (icon == Icons.person) return 'Person';
                if (icon == Icons.location_on) return 'Location';
                if (icon == Icons.favorite) return 'Favorite';
                if (icon == Icons.email) return 'Email';
                if (icon == Icons.phone) return 'Phone';
                return 'Unknown';
              },
            ),
            text: context.knobs.string(
              label: 'Text',
              initialValue: 'Your date of birth',
            ),
            showBackgroundIcon: context.knobs.boolean(
              label: 'Show background icon',
              initialValue: true,
            ),
            onBack: () {
              // Action de retour
            },
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Without back button',
        builder: (context) => Container(
          color: const Color(0xFF2C2C2C),
          child: HeaderEAE(
            icon: context.knobs.list(
              label: 'Icon',
              options: [
                Icons.calendar_today,
                Icons.person,
                Icons.location_on,
                Icons.favorite,
              ],
              labelBuilder: (icon) {
                if (icon == Icons.calendar_today) return 'Calendar';
                if (icon == Icons.person) return 'Person';
                if (icon == Icons.location_on) return 'Location';
                if (icon == Icons.favorite) return 'Favorite';
                return 'Unknown';
              },
            ),
            text: context.knobs.string(
              label: 'Text',
              initialValue: 'Your profile',
            ),
            onBack: null, // Pas de bouton back
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Without background icon',
        builder: (context) => Container(
          color: const Color(0xFF2C2C2C),
          child: HeaderEAE(
            icon: Icons.calendar_today,
            text: 'Your date of birth',
            onBack: () {},
            showBackgroundIcon: false,
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Custom colors (light background)',
        builder: (context) => Container(
          color: Colors.white,
          child: HeaderEAE(
            icon: Icons.calendar_today,
            text: context.knobs.string(
              label: 'Text',
              initialValue: 'Your date of birth',
            ),
            onBack: () {},
            foregroundColor: context.knobs.list(
              label: 'Foreground Color',
              options: [
                Colors.black,
                Colors.blue,
                Colors.purple,
                Colors.green,
              ],
              labelBuilder: (color) {
                if (color == Colors.black) return 'Black';
                if (color == Colors.blue) return 'Blue';
                if (color == Colors.purple) return 'Purple';
                if (color == Colors.green) return 'Green';
                return 'Unknown';
              },
            ),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Date of birth example (OKC style)',
        builder: (context) => Container(
          color: const Color(0xFF2C2C2C),
          child: const HeaderEAE(
            icon: Icons.calendar_today,
            text: 'Your date of birth',
            onBack: null,
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Profile picture example',
        builder: (context) => Container(
          color: const Color(0xFF2C2C2C),
          child: HeaderEAE(
            icon: Icons.camera_alt,
            text: 'Add a profile picture',
            onBack: () {},
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Location example',
        builder: (context) => Container(
          color: const Color(0xFF2C2C2C),
          child: HeaderEAE(
            icon: Icons.location_on,
            text: 'Where are you located?',
            onBack: () {},
          ),
        ),
      ),
    ],
  );
}

