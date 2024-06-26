part of '../main.dart';

class LocalStudyProtocolManager implements StudyProtocolManager {
  @override
  Future<SmartphoneStudyProtocol?> getStudyProtocol(String id) async =>
      getProtocol(id);

  @override
  Future<void> initialize() async {}

  StudyDescription get studyDescription => StudyDescription(
      title: 'Digital Health Measurements',
      description: 'Collects activity data from smartphone sensors',
      purpose:
          'To understand correlations between mental and physical health using Natural Language Models');

  DataEndPoint get dataEndPoint => SQLiteDataEndPoint();

  getProtocol(String id) {
    SmartphoneStudyProtocol protocol = SmartphoneStudyProtocol(
        name: id,
        studyDescription: studyDescription,
        dataEndPoint: dataEndPoint);

    const participant = 'Participant';
    protocol.participantRoles?.add(ParticipantRole(participant, false));

    Smartphone phone = Smartphone();
    protocol.addPrimaryDevice(phone);
    final healthService = HealthService();
    protocol.addConnectedDevice(healthService, phone);

    protocol.addTaskControl(
        PeriodicTrigger(period: const Duration(minutes: 2)),
        BackgroundTask(measures: [
          HealthSamplingPackage.getHealthMeasure([HealthDataType.STEPS])
        ]),
        healthService);
    return protocol;
  }

  @override
  Future<bool> saveStudyProtocol(
      String id, SmartphoneStudyProtocol protocol) async {
    throw UnimplementedError();
  }
}
