// ignore_for_file: unused_import

library digital_health_module;

import 'dart:convert';

import 'package:carp_core/carp_core.dart';
import 'package:carp_context_package/carp_context_package.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_health_package/health_package.dart';
import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:flutter/cupertino.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

//JSON import
import 'package:json_annotation/json_annotation.dart';

part 'src/local_study_protocol_manager.dart';
part 'src/study_bloc.dart';
part 'src/data_endpoint.dart';

Future initializeModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions();
  CarpMobileSensing.ensureInitialized();
  await bloc.initialise();
}

Future<void> requestPermissions() async {
  await Permission.activityRecognition.request();
  await Permission.location.request();
  await HealthServiceManager().requestPermissions();
}

Future addStudy(String id) async {
  info('Set Study: $id');
  bloc.addStudy();
}

Future startStudy() async {
  bloc.startStudy();
}

Future stopStudy() async {
  bloc.stopStudy();
}

Future disposeStudy() async {
  bloc.disposeStudy();
}

final bloc = StudyBLoC();
