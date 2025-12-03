import 'package:widgetbook/widgetbook.dart';
import 'slider_usecases.dart';
import 'height_slider_usecases.dart';

/// Folder contenant les usecases des sliders
WidgetbookFolder buildSlidersFolder() {
  return WidgetbookFolder(
    name: 'Sliders',
    children: [
      WidgetbookComponent(
        name: 'SliderEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const SliderUsecases(),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'HeightSliderEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const HeightSliderUsecases(),
          ),
        ],
      ),
    ],
  );
}

