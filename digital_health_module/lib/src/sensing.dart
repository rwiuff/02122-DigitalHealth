// part of '../main.dart';

// class Sensing {
//   static final Sensing _instance = Sensing._();
//   factory Sensing() => _instance;

//   Sensing._() : super() {
//     CarpMobileSensing.ensureInitialized();

//     SamplingPackageRegistry().register(HealthSamplingPackage());

//     DataManagerRegistry().register(CarpDataManagerFactory());
//   }

//   StudyDeployment? _status;

//   DeploymentService? deploymentService;

//   Study? study;

//   StudyDeployment? get status => _status;

//   // String? get deviceRoleName => _status?.primaryDeviceStatus?.device.roleName;

//   SmartphoneDeploymentController? get controller => (study != null)
//       ? SmartPhoneClientManager().getStudyRuntime(study!)
//       : null;

//   Stream<Measurement> get measurements =>
//       controller?.measurements ?? const Stream.empty();

//   List<Probe> get runningProbes =>
//       (controller != null) ? controller!.executor.probes : [];

//   List<DeviceManager> get availableDevices =>
//       SmartPhoneClientManager().deviceController.devices.values.toList();

//   Future<void> initialize() async {
//     info('Initialising $runtimeType');

//     deploymentService = SmartphoneDeploymentService();

//     StudyProtocol protocol =
//         (await LocalProtocolManager().getStudyProtocol('')) as StudyProtocol;

//     _status = (await SmartphoneDeploymentService().createStudyDeployment(
//       protocol,
//       [],
//       bloc.studyDeploymentId,
//     )) as StudyDeployment?;

//     bloc.studyDeploymentId = _status?.studyDeploymentId;
//     // bloc.deviceRoleName = _status?.primaryDeviceStatus?.device.roleName;

//     await SmartPhoneClientManager().configure(
//       deploymentService: deploymentService,
//       askForPermissions: true,
//     );

//     study = await SmartPhoneClientManager().addStudy(
//       bloc.studyDeploymentId!,
//       bloc.deviceRoleName!,
//     );

//     await controller?.tryDeployment(useCached: bloc.useCachedStudyDeployment);
//     await controller?.configure();

//     SmartPhoneClientManager()
//         .measurements
//         .listen((measurement) => print(toJsonString(measurement)));

//     info('$runtimeType initializsed');
//   }
// }
