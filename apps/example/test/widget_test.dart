import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('ShowcaseApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Packages Showcase'), findsOneWidget);
  });
}
