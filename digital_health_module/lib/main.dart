// ignore_for_file: unused_import

library digital_health_module;

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_health_package/health_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// part 'src/local_protocol_manager.dart';
// part 'src/backend.dart';
// part 'src/sensing.dart';
// part 'src/sensing_bloc.dart';
part 'src/study_bloc.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future initializeModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestExactAlarmsPermission();
  await Permission.activityRecognition.request();
  await Permission.location.request();
  CarpMobileSensing.ensureInitialized();
  await bloc.initialise();
}

Future setStudy(String id) async {
  debugPrint('Set Study: $id');
  bloc.setStudy();
}

Future startStudy() async {
  bloc.startStudy();
}

Future stopStudy() async {}

Future disposeStudy() async {}

final bloc = StudyBLoC();
