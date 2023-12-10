import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:playground/my_app.dart';

void main() {
  testWidgets('Clicking a tile opens it', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byIcon(Icons.launch), findsNothing);

    await tester.tap(find.byType(ExpansionTile).first);

    await tester.pump(Duration.zero);

    expect(find.byIcon(Icons.launch), findsOneWidget);
  }, skip: true);
}
