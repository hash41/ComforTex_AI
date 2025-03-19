import 'package:comfortex_ai/layout/components/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test BottomWidget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: BottomWidget()));
    // Verify that the text is displayed.
    expect(find.text('Garment Properties'), findsOneWidget);
  });
}