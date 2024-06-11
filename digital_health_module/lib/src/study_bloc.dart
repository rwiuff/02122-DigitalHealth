part of '../main.dart';

class StudyBLoC {
  final phone = Smartphone();
  late SmartphoneStudyProtocol protocol;
  Future<void> initialise() async {
    SamplingPackageRegistry().register(HealthSamplingPackage());
    protocol = SmartphoneStudyProtocol(
      name: 'Test Protocol',
      dataEndPoint: SQLiteDataEndPoint(),
    );
    protocol.addPrimaryDevice(phone);
    await SmartPhoneClientManager().configure();
    info('$runtimeType initialized');
  }

  Future<void> setStudy()async{
    protocol.addTaskControl(DelayedTrigger(delay: const Duration(seconds: 10)),
    BackgroundTask(measures: [
      Measure(type: SensorSamplingPackage.STEP_COUNT),
    ]),
    phone);
    SmartPhoneClientManager().addStudyProtocol(protocol);
    info('Study set');
  }

  Future<void> startStudy()async{
    SmartPhoneClientManager().start();
    info('Study started');
    SmartPhoneClientManager()
    .measurements
    .listen((measurement) => debugPrint(toJsonString(measurement)));
  }
}
