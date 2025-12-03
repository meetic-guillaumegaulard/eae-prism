import 'package:widgetbook/widgetbook.dart';
import 'icon_usecases.dart';

/// Folder contenant les usecases des icônes
WidgetbookFolder buildIconsFolder() {
  return WidgetbookFolder(
    name: 'Icons',
    children: [
      WidgetbookComponent(
        name: 'IconEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const IconUsecases(),
          ),
        ],
      ),
    ],
  );
}

