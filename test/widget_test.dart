import 'package:flutter_test/flutter_test.dart';

import '../main.dart';

void main() {
  testWidgets('Camillian Connect app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CamillianConnectApp());

    expect(find.text('Camillian Connect'), findsOneWidget);
  });
}
