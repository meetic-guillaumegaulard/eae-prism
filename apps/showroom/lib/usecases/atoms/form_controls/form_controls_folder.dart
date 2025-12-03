import 'package:widgetbook/widgetbook.dart';
import 'checkbox_usecases.dart';
import 'radio_button_usecases.dart';
import 'text_input_usecases.dart';
import 'toggle_usecases.dart';

/// Folder contenant les usecases des contrôles de formulaire
WidgetbookFolder buildFormControlsFolder() {
  return WidgetbookFolder(
    name: 'Form Controls',
    children: [
      WidgetbookComponent(
        name: 'CheckboxEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => buildCheckbox(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'RadioButtonEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => buildRadioButton(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'TextInputEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => buildDefaultTextInput(context),
          ),
          WidgetbookUseCase(
            name: 'States',
            builder: (context) => buildTextInputStates(context),
          ),
          WidgetbookUseCase(
            name: 'No Label',
            builder: (context) => buildTextInputNoLabel(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'ToggleEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Default',
            builder: (context) => buildToggle(context),
          ),
          WidgetbookUseCase(
            name: 'States',
            builder: (context) => buildToggleStates(context),
          ),
        ],
      ),
    ],
  );
}

