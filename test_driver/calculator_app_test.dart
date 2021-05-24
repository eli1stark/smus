// flutter driver shouldn't depend on any flutter library
// that's why we are using test package instead of flutter_test
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() {
    driver.close();
  });

  test('the values of stream is 1 ... 10', () async {
    for (var i = 0; i <= 10; i++) {
      await driver.waitFor(find.text('stream is $i'));
    }
    await driver.takeScreenshot('stream is 10');
  });

  test('tests addition', () async {
    await driver.tap(find.byValueKey('top_add'));
    await driver.enterText('5');
    await driver.tap(find.byValueKey('bottom_add'));
    await driver.enterText('10');
    await driver.waitFor(find.text('plus is 15.0'));
    await driver.takeScreenshot('plus is 15.0');
  });
}

extension on FlutterDriver {
  Future<void> takeScreenshot(String name) async {
    final filePath = File('screenshots/$name.png');
    if (await filePath.exists()) {
      await filePath.delete(recursive: true);
    }
    final file = await filePath.create(recursive: true);
    final png = await screenshot();
    file.writeAsBytesSync(png);
    print('screenshot with name $name was taken');
  }
}
