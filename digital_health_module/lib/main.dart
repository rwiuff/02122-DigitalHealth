// ignore_for_file: unused_import

library digital_health_module;

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_health_package/health_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// part 'src/local_protocol_manager.dart';
// part 'src/backend.dart';
// part 'src/sensing.dart';
// part 'src/sensing_bloc.dart';
part 'src/study_bloc.dart';

Future initializeModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  debugPrint('Running initNoti');
  const AndroidInitializationSettings initialisationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initialisationSettings =
      InitializationSettings(android: initialisationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initialisationSettings);
  debugPrint('flutterLocalNofiPlgi initialised');
  await requestPermissions();
  CarpMobileSensing.ensureInitialized();
  await bloc.initialise();
}

Future<void> requestPermissions() async{
  await Permission.activityRecognition.request();
  await Permission.location.request();
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
