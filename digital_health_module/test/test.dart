// ignore_for_file: unused_import

library digital_health_module;

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_health_module/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


void main() {
  test('Initialize Module', () async {
    await initializeModule();
    expect(SmartPhoneClientManager().state.toString(), "created");
  });

<<<<<<< HEAD
  test('Add Study', () async {
=======
  test('Set Study', () async {
>>>>>>> b57b8958a65ab1d655b7b48dd9c5c31b50d1c085
    await addStudy('test_study_id');
    expect(SmartPhoneClientManager().state.toString(), "configured");
  });

  test('Start Study', () async {
    await startStudy();
    expect(SmartPhoneClientManager().state.toString(), "started");
  });

  test('Stop Study', () async {
    await stopStudy();
    expect(SmartPhoneClientManager().state.toString(), "stopped");
  });

  test('Dispose Study', () async {
    await disposeStudy();
    expect(SmartPhoneClientManager().state.toString(), "disposed");
  });
}