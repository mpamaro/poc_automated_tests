import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_automated_tests/home.dart';

void main() {
  group('Home', () {
    testWidgets(
      'Home should have a title and a custom message',
      _homeShouldHaveTitleAndCustomMessage,
    );

    testWidgets(
      'Home should have a title and a default message',
      _homeShouldHaveTitleAndDefaultMessage,
    );

    // testWidgets(
    //   'Counter text should update when the increment button is pressed.',
    //   _counterTextShouldUpdateWhenIncrementButtonIsPressed,
    // );

    testWidgets(
      'GIVEN counter is 0 '
      'WHEN user taps increment button '
      'THEN counter should be 1',
      _counterTextShouldUpdateWhenIncrementButtonIsPressed,
    );

    testWidgets(
      'Counter text should update when the decrement button is pressed.',
      _counterTextShouldUpdateWhenDecrementButtonIsPressed,
    );

    testWidgets(
      'HTTP button should be clickable',
      _httpButtonShouldBeClickable,
    );

    testWidgets(
      'Golden test',
      _goldenTest,
    );
  });
}

Future<void> _homeShouldHaveTitleAndCustomMessage(WidgetTester tester) async {
  const String title = 'my title';
  const String message = 'my message';

  await tester.pumpWidget(
    const MaterialApp(
      home: Home(
        title: title,
        message: message,
      ),
    ),
  );

  final Finder titleFinder = find.text(title);
  Finder messageFinder = find.text(message);

  expect(titleFinder, findsOneWidget);
  expect(messageFinder, findsOneWidget);
}

Future<void> _homeShouldHaveTitleAndDefaultMessage(WidgetTester tester) async {
  const String title = 'my title';

  await tester.pumpWidget(
    const MaterialApp(
      home: Home(
        title: title,
      ),
    ),
  );

  final Finder titleFinder = find.text(title);
  Finder messageFinder = find.text(
    'You have pushed the button this many times:',
  );

  expect(titleFinder, findsOneWidget);
  expect(messageFinder, findsOneWidget);
}

Future<void> _counterTextShouldUpdateWhenIncrementButtonIsPressed(
    WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Home(
        title: 'my title',
      ),
    ),
  );

  Finder findIncrementButton = find.byKey(const ValueKey('increment-button'));
  Finder findCounterText = find.byKey(const ValueKey('counter-text'));

  expect(findIncrementButton, findsOneWidget);
  expect(findCounterText, findsOneWidget);

  String? counterTextData =
      (findCounterText.evaluate().first.widget as Text).data;
  expect(counterTextData, '0');

  await tester.tap(findIncrementButton);
  await tester.pumpAndSettle();

  counterTextData = (findCounterText.evaluate().first.widget as Text).data;
  expect(counterTextData, '1');
}

Future<void> _counterTextShouldUpdateWhenDecrementButtonIsPressed(
    WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Home(
        title: 'my title',
      ),
    ),
  );

  Finder findDecrementButton = find.byIcon(Icons.remove);
  Finder findCounterText = find.byKey(const ValueKey('counter-text'));

  expect(findDecrementButton, findsOneWidget);
  expect(findCounterText, findsOneWidget);

  String? counterTextData =
      (findCounterText.evaluate().first.widget as Text).data;
  expect(counterTextData, '0');

  await tester.tap(findDecrementButton);
  await tester.pumpAndSettle();

  counterTextData = (findCounterText.evaluate().first.widget as Text).data;
  expect(counterTextData, '-1');
}

Future<void> _httpButtonShouldBeClickable(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Home(
        title: 'my title',
      ),
    ),
  );

  Finder findButton = find.byType(ElevatedButton);

  expect(findButton, findsOneWidget);

  await tester.tap(findButton);
  await tester.pumpAndSettle();
}

Future<void> _goldenTest(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Home(
        title: 'my title',
      ),
    ),
  );

  await expectLater(
    find.byType(Home),
    matchesGoldenFile('home.png'),
  );
}
