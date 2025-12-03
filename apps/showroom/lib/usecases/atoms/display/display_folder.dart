import 'package:widgetbook/widgetbook.dart';
import 'tag_usecases.dart';
import 'progress_bar_usecases.dart';
import 'logo_usecases.dart';

/// Folder contenant les usecases des composants d'affichage
WidgetbookFolder buildDisplayFolder() {
  return WidgetbookFolder(
    name: 'Display',
    children: [
      WidgetbookComponent(
        name: 'TagEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const TagUsecases(),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'ProgressBarEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const ProgressBarUsecases(),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'LogoEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const LogoUsecases(),
          ),
        ],
      ),
    ],
  );
}

