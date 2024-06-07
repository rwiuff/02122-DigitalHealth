part of '../main.dart';

/// This is a local [StudyProtocolManager] which provides a [SmartphoneStudyProtocol]
/// when running in local mode.
class LocalStudyProtocolManager implements StudyProtocolManager {
  @override
  Future<void> initialize() async {}

  @override
  Future<SmartphoneStudyProtocol> getStudyProtocol(String protocolId) async =>
      getSingleUserStudyProtocol(protocolId);

  StudyDescription get studyDescription => StudyDescription(
      title: 'CAMS App - Sensing Coverage Study',
      description:
          'The default study testing coverage of most measures. Used in the coverage tests.',
      purpose: 'To test sensing coverage',
      responsible: StudyResponsible(
        id: 'abc',
        title: 'professor',
        address: 'Ørsteds Plads',
        affiliation: 'Technical University of Denmark',
        email: 'abc@dtu.dk',
        name: 'Alex B. Christensen',
      ));

  DataEndPoint get dataEndPoint => (bloc.deploymentMode == DeploymentMode.local)
      ? SQLiteDataEndPoint()
      : CarpDataEndPoint(
          uploadMethod: CarpUploadMethod.stream,
        )
    // set the format of the data to upload - e.g. Open mHealth
    ..dataFormat = bloc.dataFormat;

  SmartphoneStudyProtocol getSingleUserStudyProtocol(String name) {
    SmartphoneStudyProtocol protocol = SmartphoneStudyProtocol(
      // Note that CAWS require a UUID for ownerId.
      // You can put anything here (as long as it is a valid UUID), and this will be replaced with
      // the ID of the user uploading the protocol.
      ownerId: '979b408d-784e-4b1b-bb1e-ff9204e072f3',
      name: name,
      studyDescription: studyDescription,
      dataEndPoint: dataEndPoint..dataFormat = bloc.dataFormat,
    );

    // always add a participant role to the protocol
    const participant = 'Participant';
    protocol.participantRoles?.add(ParticipantRole(participant, false));

    // define the primary device(s)
    Smartphone phone = Smartphone();
    protocol.addPrimaryDevice(phone);

    // build-in measure from sensor and device sampling packages
    protocol.addTaskControl(
        ImmediateTrigger(),
        BackgroundTask(measures: [
          Measure(type: SensorSamplingPackage.STEP_COUNT),
          Measure(type: SensorSamplingPackage.AMBIENT_LIGHT),
          Measure(type: DeviceSamplingPackage.SCREEN_EVENT),
          Measure(type: DeviceSamplingPackage.FREE_MEMORY),
          Measure(type: DeviceSamplingPackage.BATTERY_STATE),
        ]),
        phone);

    // a random trigger - 3-8 times during time period of 8-20
    protocol.addTaskControl(
        RandomRecurrentTrigger(
          startTime: const TimeOfDay(hour: 8),
          endTime: const TimeOfDay(hour: 20),
          minNumberOfTriggers: 3,
          maxNumberOfTriggers: 8,
        ),
        BackgroundTask(measures: [
          Measure(type: DeviceSamplingPackage.DEVICE_INFORMATION)
        ]),
        phone);

    // Add measures to collect data from Apple Health / Google Fit

    // Create and add a health service
    final healthService = HealthService();
    protocol.addConnectedDevice(healthService, phone);

    protocol.addTaskControl(
        // PeriodicTrigger(period: Duration(minutes: 60)),
        PeriodicTrigger(period: const Duration(minutes: 1)),
        BackgroundTask(measures: [
          HealthSamplingPackage.getHealthMeasure([
            HealthDataType.STEPS,
            HealthDataType.BASAL_ENERGY_BURNED,
            HealthDataType.WEIGHT,
            HealthDataType.SLEEP_SESSION,
          ])
        ]),
        healthService);

    return protocol;
  }
  
  @override
  Future<bool> saveStudyProtocol(String studyId, SmartphoneStudyProtocol protocol) async {
    throw UnimplementedError();
  }

  //TODO connect study_protocol_manager with data_analysis and widgets
}