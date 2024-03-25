part of '../main.dart';

class Sensing {
  static final Sensing _instance = Sensing._();
  factory Sensing() => _instance;

  Sensing._() : super() {
    CarpMobileSensing.ensureInitialized();

    // Create and register external sampling packages
    SamplingPackageRegistry().register(HealthSamplingPackage());

    // Register the CARP data manager for uploading data back to CAWS.
    // This is needed in both LOCAL and CAWS deployments, since a local study
    // protocol may still upload to CAWS
    DataManagerRegistry().register(CarpDataManagerFactory());
  }

  StudyDeploymentStatus? _status;

  DeploymentService? deploymentService;

  /// The study running on this phone.
  Study? study;

  /// Get the latest status of the study deployment.
  StudyDeploymentStatus? get status => _status;

  /// The role name of this device in the deployed study
  String? get deviceRoleName => _status?.primaryDeviceStatus?.device.roleName;

  /// The study runtime controller for this deployment
  SmartphoneDeploymentController? get controller => (study != null)
      ? SmartPhoneClientManager().getStudyRuntime(study!)
      : null;

  /// The stream of all sampled measurements.
  Stream<Measurement> get measurements =>
      controller?.measurements ?? const Stream.empty();

  /// the list of running - i.e. used - probes in this study.
  List<Probe> get runningProbes =>
      (controller != null) ? controller!.executor.probes : [];

  /// The list of available devices.
  List<DeviceManager> get availableDevices =>
      SmartPhoneClientManager().deviceController.devices.values.toList();

  /// The list of connected devices.
  List<DeviceManager> get connectedDevices =>
      SmartPhoneClientManager().deviceController.connectedDevices.toList();

  /// Initialize and set up sensing.
  Future<void> initialize() async {
    info('Initializing $runtimeType - mode: ${bloc.deploymentMode}');

    switch (bloc.deploymentMode) {
      case DeploymentMode.local:
        // Use the local, phone-based deployment service.
        deploymentService = SmartphoneDeploymentService();

        // Get the protocol from the local study protocol manager.
        // Note that the study id is not used.
        StudyProtocol protocol =
            await LocalStudyProtocolManager().getStudyProtocol('');

        // Deploy this protocol using the on-phone deployment service.
        // Reuse the study deployment id, if this is stored on the phone.
        _status = await SmartphoneDeploymentService().createStudyDeployment(
          protocol,
          [],
          bloc.studyDeploymentId,
        );

        // Save the correct deployment id on the phone for later use.
        bloc.studyDeploymentId = _status?.studyDeploymentId;
        bloc.deviceRoleName = _status?.primaryDeviceStatus?.device.roleName;

        break;
      case DeploymentMode.production:
      case DeploymentMode.staging:
      case DeploymentMode.development:
        // Use the CARP deployment service which can download a protocol from CAWS
        CarpDeploymentService().configureFrom(CarpService());
        deploymentService = CarpDeploymentService();

        break;
    }

    // Configure the client manager with the deployment service selected above
    // (local or CAWS), add the study, and deploy it.
    await SmartPhoneClientManager().configure(
      deploymentService: deploymentService,
      askForPermissions: true,
    );
    study = await SmartPhoneClientManager().addStudy(
      bloc.studyDeploymentId!,
      bloc.deviceRoleName!,
    );
    await controller?.tryDeployment(useCached: bloc.useCachedStudyDeployment);
    await controller?.configure();

    // Listen on the measurements stream and print them as json.
    SmartPhoneClientManager()
        .measurements
        .listen((measurement) => print(toJsonString(measurement)));

    info('$runtimeType initialized');
  }
}