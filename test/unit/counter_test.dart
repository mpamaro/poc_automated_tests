import 'package:flutter_test/flutter_test.dart';
import 'package:poc_automated_tests/counter.dart';

void main() {
  group('Counter', () {
    test(
      'Counter value should start at 0',
      _counterValueShouldStartAtZero,
    );

    test(
      'Counter value should be incremented by 1',
      _counterValueShouldBeIncrementedByOne,
    );

    test(
      'Counter value should be decremented by 1',
      _counterValueShouldBeDecrementedByOne,
    );
  });
}

void _counterValueShouldStartAtZero() {
  expect(Counter().value, 0);
}

void _counterValueShouldBeIncrementedByOne() {
  final counter = Counter();

  final oldValue = counter.value;

  counter.increment();

  final newValue = counter.value;

  expect(newValue, oldValue + 1);
}

void _counterValueShouldBeDecrementedByOne() {
  final counter = Counter();

  final oldValue = counter.value;

  counter.decrement();

  final newValue = counter.value;

  expect(newValue, oldValue - 1);
}
