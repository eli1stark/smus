import 'dart:async';

class Calculator {
  double add(double a, double b) => a + b;

  double subtract(double a, double b) => a - b;

  double multiply(double a, double b) => a * b;

  double divide(double a, double b) {
    if (b == 0) throw ArgumentError('You cannot divide by zero');
    return a / b;
  }

  Future<double> powerOfTwo(double a) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => a * a,
    );
  }

  Stream<double> pi() {
    return Stream.fromIterable([3, 3.1, 3.14, 3.141, 3.1415]);
  }
}

class NumberGenerator {
  NumberGenerator() {
    Timer.periodic(
      const Duration(seconds: 2),
      (t) {
        _controller.sink.add(_count);
        _count++;
      },
    );
  }
  var _count = 1;

  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  Stream<int> countStream(int n) async* {
    yield 0;
    for (var i = 1; i <= n; i++) {
      // dummy delay - this could be a network request
      await Future.delayed(const Duration(seconds: 1));
      // ignore: avoid_print
      print(i);
      yield i;
    }
  }
}
