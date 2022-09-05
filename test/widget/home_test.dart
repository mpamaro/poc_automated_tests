import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_automated_tests/home.dart';

void main() {
  group('Home', () {
    testWidgets(
      'Home has a title and a custom message',
      _homeHasTitleAndCustomMessage,
    );

    testWidgets(
      'Home has a title and a default message',
      _homeHasTitleAndDefaultMessage,
    );

    testWidgets(
      'Counter text is updating when the increment button is pressed.',
      _counterTextIsUpdatingWhenIncrementButtonIsPressed,
    );

    testWidgets(
      'Counter text is updating when the decrement button is pressed.',
      _counterTextIsUpdatingWhenDecrementButtonIsPressed,
    );
  });
}

Future<void> _homeHasTitleAndCustomMessage(WidgetTester tester) async {
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

Future<void> _homeHasTitleAndDefaultMessage(WidgetTester tester) async {
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

Future<void> _counterTextIsUpdatingWhenIncrementButtonIsPressed(
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
  await tester.pump();

  counterTextData = (findCounterText.evaluate().first.widget as Text).data;
  expect(counterTextData, '1');
}

Future<void> _counterTextIsUpdatingWhenDecrementButtonIsPressed(
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
  await tester.pump();

  counterTextData = (findCounterText.evaluate().first.widget as Text).data;
  expect(counterTextData, '-1');
}
