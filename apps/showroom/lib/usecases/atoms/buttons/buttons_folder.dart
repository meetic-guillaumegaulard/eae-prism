import 'package:widgetbook/widgetbook.dart';
import 'brand_button_usecases.dart';
import 'selectable_button_usecases.dart';

/// Folder contenant les usecases des boutons
WidgetbookFolder buildButtonsFolder() {
  return WidgetbookFolder(
    name: 'Buttons',
    children: [
      WidgetbookComponent(
        name: 'ButtonEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Primary',
            builder: (context) => buildPrimaryButton(context),
          ),
          WidgetbookUseCase(
            name: 'Secondary',
            builder: (context) => buildSecondaryButton(context),
          ),
          WidgetbookUseCase(
            name: 'Outline',
            builder: (context) => buildOutlineButton(context),
          ),
          WidgetbookUseCase(
            name: 'With Icon',
            builder: (context) => buildButtonWithIcon(context),
          ),
          WidgetbookUseCase(
            name: 'Sizes',
            builder: (context) => buildButtonSizes(context),
          ),
          WidgetbookUseCase(
            name: 'Loading State',
            builder: (context) => buildLoadingButton(context),
          ),
          WidgetbookUseCase(
            name: 'Width Behavior',
            builder: (context) => buildButtonWidthBehavior(context),
          ),
          WidgetbookUseCase(
            name: 'Disabled State',
            builder: (context) => buildDisabledButton(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'SelectableButtonEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => buildSelectableButton(context),
          ),
          WidgetbookUseCase(
            name: 'Group',
            builder: (context) => buildSelectableButtonGroup(context),
          ),
          WidgetbookUseCase(
            name: 'Width Behavior',
            builder: (context) => buildSelectableButtonWidthBehavior(context),
          ),
        ],
      ),
    ],
  );
}

