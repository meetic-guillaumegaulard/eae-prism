import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:design_system/design_system.dart';
import 'usecases/atoms/atoms_category.dart';
import 'usecases/molecules/molecules_category.dart';
import 'usecases/templates/templates_category.dart';
import 'usecases/pages/pages_category.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        buildAtomsCategory(),
        buildMoleculesCategory(),
        buildTemplatesCategory(),
        buildPagesCategory(),
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
