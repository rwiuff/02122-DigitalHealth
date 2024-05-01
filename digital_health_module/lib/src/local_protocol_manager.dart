part of '../main.dart';

class LocalProtocolManager implements StudyProtocolManager {
  @override
  Future<void> initialize() async {}
  
  @override
  Future<SmartphoneStudyProtocol?> getStudyProtocol(String id) async =>
    getSingleUserStudyProtocol(id);

    StudyDescription get studyDescription => StudyDescription(
      title: "Test",
      description: "TestDescription",
      purpose: "Testing");

    DataEndPoint get dataEndPoint => (bloc.deploymentMode == DeploymentMode.local)
      ? SQLiteDataEndPoint()
      : CarpDataEndPoint(
        uploadMethod: CarpUploadMethod.stream,
      )..dataFormat = bloc.dataFormat;
    
    SmartphoneStudyProtocol getSingleUserStudyProtocol(String name) {
      SmartphoneStudyProtocol protocol = SmartphoneStudyProtocol(
        name: name,
        dataEndPoint: dataEndPoint..dataFormat = bloc.dataFormat,
      );

    const participant = 'Participant';
    protocol.participantRoles?.add(ParticipantRole(participant, false));

    Smartphone phone = Smartphone();
    protocol.addPrimaryDevice(phone);

    protocol.addTaskControl(
      ImmediateTrigger(),
      BackgroundTask(measures: [
        Measure(type: SensorSamplingPackage.STEP_COUNT),
      ]),
      phone);

    return protocol;
    
  }

  @override
  Future<bool> saveStudyProtocol(String id, SmartphoneStudyProtocol protocol) async {
    throw UnimplementedError();
  }
  
}