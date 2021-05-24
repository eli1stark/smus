import 'package:flutter/material.dart';
import 'package:hacker_news/z_calc/calculator.dart';
import 'package:hacker_news/z_calc/calculator_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCalculator extends Mock implements NumberGenerator {}

void main() {
  late NumberGenerator generator;

  setUp(() => generator = MockCalculator());

  testWidgets('paints the value returned by the Generator', (tester) async {
    when(() => generator.stream).thenAnswer(
      (invocation) => generator.countStream(10),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberGen(),
        ),
      ),
    );
    expect(find.text('stream is 0'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('stream is 1'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('stream is 2'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('stream is 3'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('stream is 4'), findsOneWidget);
  });
}
