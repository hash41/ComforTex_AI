import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/model/properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Desktop Screen Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    //await tester.pumpWidget(MaterialApp(home: DesktopScreen1(),),);
    // Verify that the text is displayed.
    expect(find.text('Garment Properties'), findsOneWidget);
    expect(find.text('Garment Type'), findsOneWidget);
    expect(find.text('Material'), findsOneWidget);
    expect(find.text('Activity Settings'), findsOneWidget);
    expect(find.text('Environmental Variables'), findsOneWidget);
    await testRadioListTile(tester, Fit.values);
    await testRadioListTile(tester, Layers.values);
    await testRadioListTile(tester, WorkIntensity.values);
    await testRadioListTile(tester, Purpose.values);
    await testRadioListTile(tester, Scenario.values);
    expect(find.byKey(const Key('Temperature (°C)')), findsOneWidget);
    expect(find.byKey(const Key('Humidity (%)')), findsOneWidget);
  });
}

///Given the values of the [RadioListTile],
/// when we tap on a RadioListTile with the specific value of [values] button
/// then it becomes checked.
///Helper function to test the [RadioListTile]

Future<void> testRadioListTile<T extends Enum>(
    WidgetTester tester, List<T> values,) async {
  for (final val in values) {
    await tester.tap(find.text(val.name));
    await tester.pump();
    RadioListTile radioOption = tester.widget(
      find.widgetWithText(
        RadioListTile<T>,
        val.name,
      ),
    );
    expect(radioOption.value, val);
    expect(radioOption.groupValue, val);
    expect(radioOption.checked, isTrue,
        reason: 'RadioListTile is tapped so then its checked',);
    for (final otherValue in values) {
      if (otherValue != val) {
        RadioListTile radioOption = tester.widget(
          find.widgetWithText(
            RadioListTile<T>,
            otherValue.name,
          ),
        );
        expect(radioOption.checked, isFalse,
            reason: 'RadioListTile is not tapped so then its not checked',);
      }
    }
  }
}
