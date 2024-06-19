part of '../main.dart';

class StudyBLoC {
  final phone = Smartphone();
  late SmartphoneStudyProtocol protocol;
  final healthService = HealthService();

  Future<void> initialise() async {
    SamplingPackageRegistry().register(HealthSamplingPackage());
    protocol = SmartphoneStudyProtocol(
      name: 'Test Protocol',
      dataEndPoint: SQLiteDataEndPoint(),
    );
    protocol.addPrimaryDevice(phone);
    protocol.addConnectedDevice(healthService, phone);
    await SmartPhoneClientManager().configure();
    info('$runtimeType initialized');
  }

  Future<void> setStudy() async {
    protocol.addTaskControl(
        DelayedTrigger(delay: const Duration(seconds: 10)),
        BackgroundTask(measures: [
          HealthSamplingPackage.getHealthMeasure([
            HealthDataType.STEPS,
          ])
        ]),
        healthService);
    SmartPhoneClientManager().addStudyProtocol(protocol);
    info('Study set');
  }

  Future<void> startStudy() async {
    SmartPhoneClientManager().start();
    info('Study started');
    SmartPhoneClientManager()
        .measurements
        .listen((measurement) => debugPrint(toJsonString(measurement)));
  }

  Future<void> stopStudy() async {
    SmartPhoneClientManager().stop();
    info('Study stopped');
  }

  Future<void> disposeStudy() async {
    SmartPhoneClientManager().dispose();
    info('Study disposed');
  }
}
