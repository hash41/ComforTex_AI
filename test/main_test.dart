import 'package:comfortex_ai/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test 1', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());
    // Verify that the text is displayed.
    expect(find.text('ComforTex AI'), findsOneWidget);
  });
}
