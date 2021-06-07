import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/z_calc/calculator.dart';

// flutter pub run test // run test with a flutter project
// pub run test // run test with a dart project

void main() {
  late Calculator calculator;

  // helper functions
  setUp(() {
    // ignore: avoid_print
    print('run before each test is run');
    calculator = Calculator();
  });
  // ignore: avoid_print
  setUpAll(() => print('run once before all tests'));
  // ignore: avoid_print
  tearDown(() => print('run after each test is run'));
  // ignore: avoid_print
  tearDownAll(() => print('run once after all tests'));

  // We can group our tests
  group('Addition', () {
    test('2 + 2 = 4', () {
      // Arrange
      const num1 = 2.0;
      const num2 = 2.0;
      // Act
      final result = calculator.add(num1, num2);
      // Assert
      expect(result, 4);
    });
    test('3 + 3 = 6', () => expect(calculator.add(3, 3), 6));
  });
  test('2 - 2 = 0', () => expect(calculator.subtract(2, 2), 0));
  test('3 * 3 = 9', () => expect(calculator.multiply(3, 3), 9));
  test('2 / 2 = 1', () => expect(calculator.divide(2, 2), 1));
  test('Positive + Positive = Positive', () {
    expect(calculator.add(2, 2), isPositive); // isPositive is a matcher
    // We can also have TypeMatcher, StreamMatcher, and CustomMatcher
  });
  test('The calculator throws an ArgumentError when dividing by 0', () {
    // error is not treated as return value
    // so we need to wrap our side effect inside an anonymous function
    expect(() => calculator.divide(2, 0), throwsArgumentError);
  });
  group('Power of 2', () {
    test('9^2 = 81', () async {
      expect(await calculator.powerOfTwo(9), 81);
    });
  });

  group('pi', () {
    test('Emits [3, 3.1, 3.14, 3.141, 3.1415] in that order', () {
      expect(
        calculator.pi(),
        emitsInOrder([3, 3.1, 3.14, 3.141, 3.1415]),
      );
    });
  });
}
