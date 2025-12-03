import 'package:widgetbook/widgetbook.dart';
import 'selectable_button_group_usecases.dart';
import 'selection_group_usecases.dart';
import 'selectable_tag_group_usecases.dart';

/// Folder contenant les usecases des groupes de composants
WidgetbookFolder buildGroupsFolder() {
  return WidgetbookFolder(
    name: 'Groups',
    children: [
      WidgetbookComponent(
        name: 'SelectableButtonGroupEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Vertical - Start',
            builder: (context) =>
                buildSelectableButtonGroupVerticalStart(context),
          ),
          WidgetbookUseCase(
            name: 'Vertical - End',
            builder: (context) =>
                buildSelectableButtonGroupVerticalEnd(context),
          ),
          WidgetbookUseCase(
            name: 'Vertical - Stretch',
            builder: (context) =>
                buildSelectableButtonGroupVerticalStretch(context),
          ),
          WidgetbookUseCase(
            name: 'Horizontal',
            builder: (context) =>
                buildSelectableButtonGroupHorizontal(context),
          ),
          WidgetbookUseCase(
            name: 'With Additional Options',
            builder: (context) =>
                buildSelectableButtonGroupWithAdditional(context),
          ),
          WidgetbookUseCase(
            name: 'Sizes',
            builder: (context) => buildSelectableButtonGroupSizes(context),
          ),
          WidgetbookUseCase(
            name: 'With Icons',
            builder: (context) =>
                buildSelectableButtonGroupWithIcons(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'SelectionGroupEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Radio - OKCupid Gender',
            builder: (context) => buildRadioGroupOKC(context),
          ),
          WidgetbookUseCase(
            name: 'Radio - Simple',
            builder: (context) => buildSimpleRadioGroup(context),
          ),
          WidgetbookUseCase(
            name: 'Checkbox - With Action',
            builder: (context) => buildCheckboxGroup(context),
          ),
          WidgetbookUseCase(
            name: 'Checkbox - Simple',
            builder: (context) => buildSimpleCheckboxGroup(context),
          ),
          WidgetbookUseCase(
            name: 'Compact Spacing',
            builder: (context) => buildCompactSelection(context),
          ),
          WidgetbookUseCase(
            name: 'Without Chevron',
            builder: (context) => buildNoChevronSelection(context),
          ),
          WidgetbookUseCase(
            name: 'Without Card',
            builder: (context) => buildNoCardSelection(context),
          ),
          WidgetbookUseCase(
            name: 'Max Selections (3)',
            builder: (context) => buildMaxSelectionsDemo(context),
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'SelectableTagGroupEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'All Examples',
            builder: (context) => const SelectableTagGroupUseCases(),
          ),
        ],
      ),
    ],
  );
}

