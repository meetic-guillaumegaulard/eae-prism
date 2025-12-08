import 'package:flutter_test/flutter_test.dart';
import 'package:design_system/design_system.dart';

import 'package:client/main.dart';

void main() {
  testWidgets('App launches with brand', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(brand: Brand.match));

    // Verify that the app launches with the brand name
    expect(find.text('Bienvenue sur Match'), findsOneWidget);
  });
}
