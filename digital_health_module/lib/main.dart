library digital_health_module;

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_health_package/health_package.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:carp_backend/carp_backend.dart';
import 'package:carp_webservices/carp_services/carp_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

part 'src/sensing_bloc.dart';
part 'src/sensing.dart';
part 'src/study_protocol_manager.dart';

Future initializeModule() async {
  CarpMobileSensing.ensureInitialized();

  await bloc.initialize(
    deploymentMode: DeploymentMode.local,
    useCachedStudyDeployment: false,
    resumeSensingOnStartup: false,
  );
}

final bloc = SensingBLoC();