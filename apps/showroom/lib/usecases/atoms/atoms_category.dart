import 'package:widgetbook/widgetbook.dart';
import 'buttons/buttons_folder.dart';
import 'form_controls/form_controls_folder.dart';
import 'sliders/sliders_folder.dart';
import 'display/display_folder.dart';
import 'text/text_folder.dart';
import 'icons/icons_folder.dart';

/// Catégorie Atoms - composants de base du design system
WidgetbookCategory buildAtomsCategory() {
  return WidgetbookCategory(
    name: 'Atoms',
    children: [
      buildButtonsFolder(),
      buildFormControlsFolder(),
      buildSlidersFolder(),
      buildDisplayFolder(),
      buildTextFolder(),
      buildIconsFolder(),
    ],
  );
}

