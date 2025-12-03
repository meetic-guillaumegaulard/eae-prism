import 'package:widgetbook/widgetbook.dart';
import 'dynamic_screen/dynamic_screen_usecases.dart';

/// Catégorie Pages - pages complètes et écrans dynamiques
WidgetbookCategory buildPagesCategory() {
  return WidgetbookCategory(
    name: 'Pages',
    children: [
      WidgetbookComponent(
        name: 'DynamicScreen',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const DynamicScreenUsecases(),
          ),
        ],
      ),
    ],
  );
}

