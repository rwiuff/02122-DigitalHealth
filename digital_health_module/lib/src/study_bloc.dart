part of '../main.dart';

class StudyBLoC {
  final deploymentService = SmartphoneDeploymentService();
  Study? study;

  Future<void> initialise() async {
    SamplingPackageRegistry().register(HealthSamplingPackage());
    SamplingPackageRegistry().register(ContextSamplingPackage());
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
    SmartPhoneClientManager().deviceController.registerAllAvailableDevices();
    info('Study added');
  }

  Future<void> startStudy() async {
    SmartPhoneClientManager().notificationController?.createNotification(
        title: 'Data Collection Started', body: 'Data sampling now running');
    SmartPhoneClientManager().start();
    // HealthServiceManager().stopHeartbeatMonitoring();
    // HealthServiceManager().requestPermissions();
    // HealthServiceManager().connect();
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
