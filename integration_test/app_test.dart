import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:poc_automated_tests/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-To-End', () {
    testWidgets(
      'App should initialize and interacts nicely',
      (tester) async {
        app.main();

        await tester.pumpAndSettle();

        await _counterTextShouldUpdateWhenIncrementButtonIsPressed(tester);
        await _counterTextShouldUpdateWhenDecrementButtonIsPressed(tester);
      },
    );
  });
}

Future<void> _counterTextShouldUpdateWhenIncrementButtonIsPressed(
    WidgetTester tester) async {
  Finder counterFinder = find.byKey(const ValueKey('counter-text'));
  Finder incrementFinder = find.byKey(const ValueKey('increment-button'));

  expect(counterFinder, findsOneWidget);
  expect((counterFinder.evaluate().first.widget as Text).data, '0');

  await tester.tap(incrementFinder);
  await tester.pump();

  expect((counterFinder.evaluate().first.widget as Text).data, '1');
}

Future<void> _counterTextShouldUpdateWhenDecrementButtonIsPressed(
    WidgetTester tester) async {
  Finder counterFinder = find.byKey(const ValueKey('counter-text'));
  Finder decrementFinder = find.byIcon(Icons.remove);

  expect(counterFinder, findsOneWidget);
  expect((counterFinder.evaluate().first.widget as Text).data, '1');

  await tester.tap(decrementFinder);
  await tester.pump();

  expect((counterFinder.evaluate().first.widget as Text).data, '0');
}
