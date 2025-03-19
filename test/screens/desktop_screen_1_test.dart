import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Desktop Screen Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: DesktopScreen1()));
    // Verify that the text is displayed.
    expect(find.text('Garment Properties'), findsOneWidget);
    expect(find.text('Garment Type'), findsOneWidget);
    expect(find.text('Material'), findsOneWidget);
    expect(find.text('Activity Settings'), findsOneWidget);
    expect(find.text('Environmental Variables'), findsOneWidget);
    await tester.tap(find.text('loose'));
    await tester.pump();
    final option = tester.widget(find.widgetWithText(RadioListTile, 'loose'));
    // for(WorkIntensity val in WorkIntensity.values){
    //   await tester.tap(find.text(val.name));
    //   await tester.pump();
    //   RadioListTile radioOption = tester.widget(
    //     find.widgetWithText(RadioListTile, val.name,),);
      //expect(radioOption.checked, isFalse);
    //}
  });
}