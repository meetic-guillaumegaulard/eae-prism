import 'package:widgetbook/widgetbook.dart';
import 'screen_layout/screen_layout_usecases.dart';
import 'screen_layout/screen_layout_interactive_usecases.dart';
import 'landing_screen/landing_screen_usecases.dart';

/// Catégorie Templates - layouts et structures de page
WidgetbookCategory buildTemplatesCategory() {
  return WidgetbookCategory(
    name: 'Templates',
    children: [
      WidgetbookComponent(
        name: 'ScreenLayoutEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const ScreenLayoutUsecases(),
          ),
          WidgetbookUseCase(
            name: 'Interactive Test',
            builder: (context) => const ScreenLayoutInteractiveUsecases(),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'LandingScreenEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Basic Demo',
            builder: (context) => const LandingScreenUsecases(),
          ),
          WidgetbookUseCase(
            name: 'With Background',
            builder: (context) => const LandingScreenWithBackgroundDemo(),
          ),
        ],
      ),
    ],
  );
}
