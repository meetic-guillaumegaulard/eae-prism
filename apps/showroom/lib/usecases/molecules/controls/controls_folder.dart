import 'package:widgetbook/widgetbook.dart';
import 'labeled_control_usecases.dart';

/// Folder contenant les usecases des contrôles labellisés
WidgetbookFolder buildControlsFolder() {
  return WidgetbookFolder(
    name: 'Controls',
    children: [
      WidgetbookComponent(
        name: 'LabeledControlEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Checkbox',
            builder: (context) => buildLabeledControlCheckbox(context),
          ),
          WidgetbookUseCase(
            name: 'Toggle',
            builder: (context) => buildLabeledControlToggle(context),
          ),
          WidgetbookUseCase(
            name: 'Control on Right',
            builder: (context) => buildLabeledControlRight(context),
          ),
          WidgetbookUseCase(
            name: 'Meetic Example',
            builder: (context) => buildLabeledControlMeetic(context),
          ),
          WidgetbookUseCase(
            name: 'Not Expanded',
            builder: (context) => buildLabeledControlNotExpanded(context),
          ),
          WidgetbookUseCase(
            name: 'Disabled',
            builder: (context) => buildLabeledControlDisabled(context),
          ),
        ],
      ),
    ],
  );
}

