import 'package:widgetbook/widgetbook.dart';
import 'header_usecases.dart';

/// Dossier Headers dans la catégorie Molecules
WidgetbookFolder buildHeadersFolder() {
  return WidgetbookFolder(
    name: 'Headers',
    children: [
      buildHeaderUsecases(),
    ],
  );
}

