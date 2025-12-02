import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:design_system/design_system.dart';
import 'usecases/brand_button_usecases.dart';
import 'usecases/selectable_button_usecases.dart';
import 'usecases/selectable_button_group_usecases.dart';
import 'usecases/checkbox_usecases.dart';
import 'usecases/radio_button_usecases.dart';
import 'usecases/text_input_usecases.dart';
import 'usecases/toggle_usecases.dart';
import 'usecases/linked_text_usecases.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'Atoms',
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
                  builder: (context) =>
                      buildSelectableButtonWidthBehavior(context),
                ),
              ],
            ),
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
            WidgetbookComponent(
              name: 'LinkedTextEAE',
              useCases: [
                WidgetbookUseCase(
                  name: 'Simple',
                  builder: (context) => buildLinkedTextSimple(context),
                ),
                WidgetbookUseCase(
                  name: 'Multiple Links',
                  builder: (context) => buildLinkedTextMultiple(context),
                ),
                WidgetbookUseCase(
                  name: 'Long Text',
                  builder: (context) => buildLinkedTextLong(context),
                ),
                WidgetbookUseCase(
                  name: 'No Links',
                  builder: (context) => buildLinkedTextNoLinks(context),
                ),
                WidgetbookUseCase(
                  name: 'Centered',
                  builder: (context) => buildLinkedTextCenter(context),
                ),
                WidgetbookUseCase(
                  name: 'Meetic Consent',
                  builder: (context) => buildLinkedTextMeeticConsent(context),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Molecules',
          children: [
            WidgetbookComponent(
              name: 'SelectableButtonGroupEAE',
              useCases: [
                WidgetbookUseCase(
                  name: 'Vertical - Start',
                  builder: (context) => buildSelectableButtonGroupVerticalStart(context),
                ),
                WidgetbookUseCase(
                  name: 'Vertical - End',
                  builder: (context) => buildSelectableButtonGroupVerticalEnd(context),
                ),
                WidgetbookUseCase(
                  name: 'Vertical - Stretch',
                  builder: (context) => buildSelectableButtonGroupVerticalStretch(context),
                ),
                WidgetbookUseCase(
                  name: 'Horizontal',
                  builder: (context) => buildSelectableButtonGroupHorizontal(context),
                ),
                WidgetbookUseCase(
                  name: 'With Additional Options',
                  builder: (context) => buildSelectableButtonGroupWithAdditional(context),
                ),
                WidgetbookUseCase(
                  name: 'Sizes',
                  builder: (context) => buildSelectableButtonGroupSizes(context),
                ),
                WidgetbookUseCase(
                  name: 'With Icons',
                  builder: (context) => buildSelectableButtonGroupWithIcons(context),
                ),
              ],
            ),
          ],
        ),
      ],
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Match',
              data: BrandTheme.getTheme(Brand.match),
            ),
            WidgetbookTheme(
              name: 'Meetic',
              data: BrandTheme.getTheme(Brand.meetic),
            ),
            WidgetbookTheme(
              name: 'OKCupid',
              data: BrandTheme.getTheme(Brand.okc),
            ),
            WidgetbookTheme(
              name: 'Plenty of Fish',
              data: BrandTheme.getTheme(Brand.pof),
            ),
          ],
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhone13,
            Devices.android.samsungGalaxyS20,
          ],
        ),
        TextScaleAddon(
          scales: [1.0, 1.5, 2.0],
        ),
      ],
    );
  }
}
