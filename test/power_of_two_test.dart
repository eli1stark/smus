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
    when(() => calculator.powerOfTwo(3.0)).thenAnswer(
      (invocation) => Future.value(9.0),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PowerOfTwo(calculator),
        ),
      ),
    );
    await tester.enterText(find.byKey(const Key('power_of_two')), '3');
    await tester.pump();
    expect(find.text('power is 9.0'), findsOneWidget);
  });
}
