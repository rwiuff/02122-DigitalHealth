// ignore_for_file: unused_import

library digital_health_module;

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_health_package/health_package.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:carp_backend/carp_backend.dart';
// import 'package:carp_webservices/carp_auth/carp_auth.dart';
// import 'package:carp_webservices/carp_services/carp_services.dart';
import 'package:flutter/cupertino.dart';

// part 'src/local_protocol_manager.dart';
// part 'src/backend.dart';
// part 'src/sensing.dart';
// part 'src/sensing_bloc.dart';
part 'src/study_bloc.dart';

Future initializeModule() async {
  WidgetsFlutterBinding.ensureInitialized();
  CarpMobileSensing.ensureInitialized();

  await bloc.initialise(

  );
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
