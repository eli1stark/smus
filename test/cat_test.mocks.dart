// Mocks generated by Mockito 5.0.5 from annotations
// in hacker_news/test/cat_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;

import 'cat_test.dart' as _i2;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [Cat].
///
/// See the documentation for Mockito's code generation for more information.
class MockCat extends _i1.Mock implements _i2.Cat {
  MockCat() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String sound() =>
      (super.noSuchMethod(Invocation.method(#sound, []), returnValue: '')
          as String);
  @override
  int add(int? num1, int? num2) =>
      (super.noSuchMethod(Invocation.method(#add, [num1, num2]), returnValue: 0)
          as int);
}