import 'package:widgetbook/widgetbook.dart';
import 'text_usecases.dart';
import 'linked_text_usecases.dart';

/// Folder contenant les usecases des composants texte
WidgetbookFolder buildTextFolder() {
  return WidgetbookFolder(
    name: 'Text',
    children: [
      WidgetbookComponent(
        name: 'TextEAE',
        useCases: [
          WidgetbookUseCase(
            name: 'Typography (All Brands)',
            builder: (context) => buildTypographyComparison(context),
          ),
          WidgetbookUseCase(
            name: 'All Text Types',
            builder: (context) => buildAllTextTypes(context),
          ),
          WidgetbookUseCase(
            name: 'Shorthand Constructors',
            builder: (context) => buildShorthandConstructors(context),
          ),
          WidgetbookUseCase(
            name: 'Customization',
            builder: (context) => buildTextCustomization(context),
          ),
          WidgetbookUseCase(
            name: 'Overflow',
            builder: (context) => buildTextOverflow(context),
          ),
          WidgetbookUseCase(
            name: 'Real World Example',
            builder: (context) => buildRealWorldExample(context),
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
  );
}

