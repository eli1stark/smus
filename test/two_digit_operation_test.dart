import 'package:flutter/material.dart';
import 'package:hacker_news/z_calc/calculator.dart';
import 'package:hacker_news/z_calc/calculator_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCalculator extends Mock implements Calculator {}

void main() {
  late Calculator calculator;

  setUp(() => calculator = MockCalculator());

  testWidgets('paints the value returned by the calculator', (tester) async {
    // In this particular case on the UI side by design we are calling
    // calculator.add() 3 times on each interaction:
    // 1) when we have intial state => calculator.add(0.0, 0.0)
    // 2) when we entered 3 => calculator.add(3.0, 0.0)
    // 3) when we entered 1 => calculator.add(3.0, 1.0)
    // Our goal is to test 3rd case but we need to create all stubs
    // in order for our test function properly
    when(() => calculator.add(0.0, 0.0)).thenReturn(25.0);
    when(() => calculator.add(3.0, 0.0)).thenReturn(25.0);
    when(() => calculator.add(3.0, 1.0)).thenReturn(25.0);
    // If we are not interested in arguments and our goal is to just mock result
    // we can just use any() - An argument matcher that matches any argument passed in.
    // when(() => calculator.add(any(), any())).thenReturn(25.0); So, we don't need 3 stubs above

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TwoDigitOperation(
            calculator: calculator,
            operation: Operation.add,
            topKey: '1',
            bottomKey: '2',
          ),
        ),
      ),
    );
    await tester.enterText(find.byKey(const Key('1')), '3');
    await tester.enterText(find.byKey(const Key('2')), '1');
    await tester.pump();
    expect(find.text('plus is 25.0'), findsOneWidget);
    verify(() => calculator.add(any(), any())).called(3);
  });
}
