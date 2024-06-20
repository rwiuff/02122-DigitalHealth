part of '../main.dart';

class StudyBLoC {
  final phone = Smartphone();
  late SmartphoneStudyProtocol protocol;
  final client = SmartPhoneClientManager();
  final healthService = HealthService();
  late SmartphoneDeploymentController controller;

  Future<void> initialise() async {
    SamplingPackageRegistry().register(HealthSamplingPackage());
    for (var package in SamplingPackageRegistry().packages) {
      info('Registered package ${package.runtimeType}');
    }
    protocol = SmartphoneStudyProtocol(
      name: 'Test Protocol',
      dataEndPoint: SQLiteDataEndPoint(),
    );
    protocol.addPrimaryDevice(phone);
    protocol.addConnectedDevice(healthService, phone);
    await client.configure();
    info('$runtimeType initialized');
  }

  Future<void> setStudy() async {
    protocol.addTaskControl(
        PeriodicTrigger(period: const Duration(minutes: 2)),
        BackgroundTask(measures: [
          HealthSamplingPackage.getHealthMeasure([
            HealthDataType.STEPS,
          ])
        ]),
        healthService,
        Control.Start);
    Study study = await client.addStudyProtocol(protocol);
    controller = client.getStudyRuntime(study)!;
    info('Study set');
  }

  Future<void> startStudy() async {
    HealthServiceManager().requestPermissions();
    controller.start();
    info('Study started');
    controller
        .measurements
        .listen((measurement) => debugPrint(toJsonString(measurement)));
  }

  Future<void> stopStudy() async {
    controller.stop();
    info('Study stopped');
  }

  Future<void> disposeStudy() async {
    controller.dispose();
    info('Study disposed');
  }
}
