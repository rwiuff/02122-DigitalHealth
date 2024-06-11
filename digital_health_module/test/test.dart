// ignore_for_file: unused_import

library digital_health_module;

import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digital_health_module/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


void main() {
  test('Initialize Module', () async {
    await initializeModule();
    
  });

  test('Set Study', () async {
    int temp = SmartPhoneClientManager().studyCount;
    await setStudy('test_study_id');
    expect(SmartPhoneClientManager().studyCount, temp+1);
  });

  test('Start Study', () async {
    await startStudy();
    
    
  });

  test('Stop Study', () async {
    await stopStudy();
    
  });

  test('Dispose Study', () async {
    await disposeStudy();
    
  });
}