import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cat_test.mocks.dart';

class Cat {
  String sound() => 'Meow';

  int add(int num1, int num2) => num1 + num2;
}

@GenerateMocks([Cat])
void main() {
  late Cat cat;

  setUp(() {
    cat = MockCat();
  });

  test('test a Purr', () {
    when(cat.sound()).thenReturn('Purr');
    expect(cat.sound(), 'Purr');
  });

  test('test a Mour', () {
    when(cat.sound()).thenReturn('Mour');
    expect(cat.sound(), 'Mour');
  });

  test('test a add cat', () {
    when(cat.add(2, 4)).thenReturn(6);

    expect(cat.add(2, 4), 6);
  });
}
