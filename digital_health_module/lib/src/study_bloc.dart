part of '../main.dart';

class StudyBLoC {
  final deploymentService = SmartphoneDeploymentService();
  Study? study;

  final healthService = HealthService();

  Future<void> initialise() async {
    SamplingPackageRegistry().register(HealthSamplingPackage());
    HealthServiceManager().requestPermissions();
    await Settings().init();
    info('$runtimeType initialized');
  }

  Future<void> addStudy() async {
    StudyProtocol protocol = (await LocalStudyProtocolManager()
        .getStudyProtocol('')) as StudyProtocol;
    await SmartphoneDeploymentService().createStudyDeployment(protocol);
    await SmartPhoneClientManager().configure(
        deploymentService: deploymentService, askForPermissions: true);
    study = await SmartPhoneClientManager().addStudyProtocol(protocol);
    info('Study added');
  }

  Future<void> startStudy() async {
    SmartPhoneClientManager().notificationController?.createNotification(
        title: 'Data Collection Started', body: 'Data sampling now running');
    SmartPhoneClientManager().start();
    SmartPhoneClientManager().measurements.listen((measurement) => debugPrint(toJsonString(measurement)));
    info('Study started');
  }

  void stopStudy() {
    SmartPhoneClientManager().notificationController?.createNotification(
          title: 'Data Collection Stopped',
          body: 'Data sampling is no longet running',
        );
    SmartPhoneClientManager().stop();
    info('Study stopped');
  }

  void disposeStudy() {
    SmartPhoneClientManager().dispose();
    info('Study disposed');
  }
}
