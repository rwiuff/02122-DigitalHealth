import 'package:flutter_test/flutter_test.dart';
import 'package:package_mvp/package_mvp.dart';
import 'package:package_mvp/src/sensing.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });


//test For sensing.dart

test('initialize', () async {
    final sensor = Sensing();
    sensor.initialize();
    expect(sensor.isInit, true);
  });


  test('start', () {
    final sensor = Sensing();
    sensor.start();
    expect(sensor.isRunning, true);
  });

  test('stop', () {
    final sensor = Sensing();
    sensor.stop();
    expect(sensor.isRunning , false);
  });

test('dispose', () {
  final sensor = Sensing();
  sensor.dispose();
  expect(sensor.isRunning, false);

  // Attempt to start the sensor again should throw an error
  expect(() => sensor.start(), throwsA(isA<StateError>()));
});

}
