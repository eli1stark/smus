import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/z_calc/calculator_app.dart';

// flutter_test is for testing widgets
// test is for unit tests

void main() {
  group('CalculatorApp', () {
    testWidgets('mathces golden file', (tester) async {
      await tester.pumpWidget(CalculatorApp());
      await expectLater(
        find.byType(CalculatorApp),
        matchesGoldenFile('goldens/calculator_app.png'),
      );
    });

    testWidgets(
      'renders 4 widgets of type TwoDigitOperation',
      // WidgetTester interacts with widgets and the test environment.
      (WidgetTester tester) async {
        // pumpWidget renders UI from the given Widget
        await tester.pumpWidget(CalculatorApp());
        expect(find.byType(TwoDigitOperation), findsNWidgets(4));
      },
    );

    group('Add', () {
      testWidgets('shows result when given 2 numbers', (tester) async {
        await tester.pumpWidget(CalculatorApp());
        await tester.enterText(find.byKey(const Key('top_add')), '3');
        await tester.enterText(find.byKey(const Key('bottom_add')), '6');
        // this will fail because it will be a new frame
        // expect(find.text('plus is 9.0'), findsOneWidget);
        // so we need to tell flutter to render a new frame and the check
        await tester.pump(); // triggers a frame
        expect(find.text('plus is 9.0'), findsOneWidget); // passes
        // but pump is limited it only updates a single frame
        // that's not useful when we are working with animation
        // see Subtract group below
      });
    });

    group('Subtract', () {
      testWidgets('shows result when given 2 numbers', (tester) async {
        await tester.pumpWidget(CalculatorApp());
        await tester.enterText(find.byKey(const Key('top_subtract')), '3');
        await tester.enterText(find.byKey(const Key('bottom_subtract')), '6');
        // pumps until animation is over
        await tester.pumpAndSettle();
        expect(find.text('subtract is -3.0'), findsOneWidget);
      });
    });
  });
}
