import 'package:widgetbook/widgetbook.dart';
import 'groups/groups_folder.dart';
import 'controls/controls_folder.dart';
import 'headers/headers_folder.dart';

/// Catégorie Molecules - composants composés de plusieurs atoms
WidgetbookCategory buildMoleculesCategory() {
  return WidgetbookCategory(
    name: 'Molecules',
    children: [
      buildGroupsFolder(),
      buildControlsFolder(),
      buildHeadersFolder(),
    ],
  );
}

