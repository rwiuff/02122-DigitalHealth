// lib/src/protocols/local_protocol_manager.dart

import 'package:package_mvp/src/carp_service.dart';

class LocalProtocolManager implements StudyProtocolManager {
  @override
  Future<void> initialize() async {
    // Initialization logic if needed
  }

  @override
  Future<SmartphoneStudyProtocol?> getStudyProtocol(String id) async {
    return getSingleUserStudyProtocol(id);
  }

  StudyDescription get studyDescription => StudyDescription(
        title: "Test",
        description: "TestDescription",
        purpose: "Testing",
      );

  DataEndPoint get dataEndPoint {
    return (CarpService().deploymentMode == DeploymentMode.local)
        ? SQLiteDataEndPoint()
        : CarpDataEndPoint(
            uploadMethod: CarpUploadMethod.stream,
          )..dataFormat = CarpService().dataFormat;
  }

  SmartphoneStudyProtocol getSingleUserStudyProtocol(String name) {
    SmartphoneStudyProtocol protocol = SmartphoneStudyProtocol(
      name: name,
      dataEndPoint: dataEndPoint..dataFormat = CarpService().dataFormat,
    );

    const participant = 'Participant';
    protocol.participantRoles.add(ParticipantRole(participant, false));

    Smartphone phone = Smartphone();
    protocol.addPrimaryDevice(phone);

    protocol.addTaskControl(
      ImmediateTrigger(),
      BackgroundTask(measures: [
        Measure(type: SensorSamplingPackage.STEP_COUNT),
      ]),
      phone,
    );

    return protocol;
  }

  @override
  Future<bool> saveStudyProtocol(String id, SmartphoneStudyProtocol protocol) async {
    // Implement saving logic if needed
    throw UnimplementedError();
  }
}

// Assuming these are part of the framework you're using or define stubs
abstract class StudyProtocolManager {
  Future<void> initialize();
  Future<SmartphoneStudyProtocol?> getStudyProtocol(String id);
  Future<bool> saveStudyProtocol(String id, SmartphoneStudyProtocol protocol);
}

class StudyDescription {
  final String title;
  final String description;
  final String purpose;

  StudyDescription({
    required this.title,
    required this.description,
    required this.purpose,
  });
}

abstract class DataEndPoint {
  set dataFormat(String dataFormat) {}
}

class SQLiteDataEndPoint extends DataEndPoint {
  @override
  String? dataFormat;
  
  SQLiteDataEndPoint({this.dataFormat});

}

class SmartphoneStudyProtocol {
  final String name;
  final DataEndPoint dataEndPoint;
  final List<ParticipantRole> participantRoles = [];
  final List<Smartphone> primaryDevices = [];

  SmartphoneStudyProtocol({
    required this.name,
    required this.dataEndPoint,
  });

  void addPrimaryDevice(Smartphone device) {
    primaryDevices.add(device);
  }

  void addTaskControl(ImmediateTrigger trigger, BackgroundTask task, Smartphone device) {
    // Task control logic
  }
}

class ImmediateTrigger {}

class Measure {
  final String type;

  Measure({required this.type});
}

class SensorSamplingPackage {
  static const String STEP_COUNT = 'STEP_COUNT';
}

class BackgroundTask {
  final List<Measure> measures;

  BackgroundTask({required this.measures});
}

class Smartphone {
  // Smartphone specific properties and methods
}

class ParticipantRole {
  final String role;
  final bool isPrimary;

  ParticipantRole(this.role, this.isPrimary);
}

class CarpDataEndPoint extends DataEndPoint {
  String? dataFormat;
  final CarpUploadMethod uploadMethod;

  CarpDataEndPoint({required this.uploadMethod});
}

enum CarpUploadMethod { stream, batch }
