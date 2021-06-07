import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'calculator.dart';

enum Operation {
  add,
  subtract,
  multiply,
  divide,
}

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  final calculator = Calculator();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // NumberGen(),
                // PowerOfTwo(calculator),
                TwoDigitOperation(
                  calculator: calculator,
                  operation: Operation.add,
                  topKey: 'top_add',
                  bottomKey: 'bottom_add',
                ),
                TwoDigitOperation(
                  calculator: calculator,
                  operation: Operation.subtract,
                  topKey: 'top_subtract',
                  bottomKey: 'bottom_subtract',
                ),
                TwoDigitOperation(
                  calculator: calculator,
                  operation: Operation.multiply,
                  topKey: 'top_multiply',
                  bottomKey: 'bottom_multiply',
                ),
                TwoDigitOperation(
                  calculator: calculator,
                  operation: Operation.divide,
                  topKey: 'top_divide',
                  bottomKey: 'bottom_divide',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwoDigitOperation extends HookWidget {
  const TwoDigitOperation({
    Key? key,
    required this.calculator,
    required this.operation,
    required this.topKey,
    required this.bottomKey,
  }) : super(key: key);

  final Calculator calculator;
  final Operation operation;
  final String topKey;
  final String bottomKey;

  @override
  Widget build(BuildContext context) {
    final num1 = useState(0.0);
    final num2 = useState(0.0);
    final subtractResult = useState(0.0);

    return Column(
      children: [
        TextField(
          key: Key(topKey),
          onChanged: (value) => num1.value = double.parse(value),
        ),
        TextField(
          key: Key(bottomKey),
          onChanged: (value) => num2.value = double.parse(value),
        ),
        if (operation == Operation.add)
          BigText(
            'plus is ${calculator.add(num1.value, num2.value)}',
          ),
        if (operation == Operation.subtract)
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            color: calculator.subtract(num1.value, num2.value) == 0.0
                ? Colors.transparent
                : Colors.lightGreen,
            onEnd: () {
              subtractResult.value =
                  calculator.subtract(num1.value, num2.value);
            },
            child: BigText(
              'subtract is ${subtractResult.value}',
            ),
          ),
        if (operation == Operation.multiply)
          BigText(
            'multiply is ${calculator.multiply(num1.value, num2.value)}',
          ),
        if (operation == Operation.divide)
          BigText(
            (num2.value == 0)
                ? 'divide is 0.0'
                : 'divide is ${calculator.divide(num1.value, num2.value)}',
          ),
      ],
    );
  }
}

class BigText extends StatelessWidget {
  const BigText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 35.0,
      ),
    );
  }
}

class PowerOfTwo extends HookWidget {
  const PowerOfTwo(this.calculator);

  final Calculator calculator;

  @override
  Widget build(BuildContext context) {
    final result = useState(0.0);

    return Column(
      children: [
        TextField(
          key: const Key('power_of_two'),
          onChanged: (value) async {
            result.value = await calculator.powerOfTwo(
              double.parse(value == '' ? '0.0' : value),
            );
          },
        ),
        BigText('power is ${result.value}')
      ],
    );
  }
}

class NumberGen extends StatelessWidget {
  final generator = NumberGenerator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: generator.countStream(10),
      builder: (context, snapshot) {
        return Text('stream is ${snapshot.data}');
      },
    );
  }
}
