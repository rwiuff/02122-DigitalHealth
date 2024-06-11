// // ignore_for_file: constant_identifier_names

// part of '../main.dart';

// /// This is the main Business Logic Component (BLoC) of this sensing app.
// class SensingBLoC {
//   static const String STUDY_ID_KEY = 'study_id';
//   static const String STUDY_DEPLOYMENT_ID_KEY = 'study_deployment_id';
//   static const String DEVICE_ROLE_NAME_KEY = 'device_role_name';

//   String? _studyId;
//   String? _studyDeploymentId;
//   String? _deviceRoleName;
//   bool _useCached = true;
//   bool _resumeSensingOnStartup = false;

//   /// The [Sensing] layer used in the app.
//   Sensing get sensing => Sensing();

//   /// The study id for the currently running deployment.
//   /// Returns the study id cached locally on the phone (if available).
//   /// Returns `null` if no study is deployed (yet).
//   String? get studyId =>
//       (_studyId ??= Settings().preferences?.getString(STUDY_ID_KEY));

//   /// Set the study deployment id for the currently running deployment.
//   /// This study deployment id will be cached locally on the phone.
//   set studyId(String? id) {
//     assert(
//         id != null,
//         'Cannot set the study id to null in Settings. '
//         "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
//     _studyId = id;
//     Settings().preferences?.setString(STUDY_ID_KEY, id!);
//   }

//   /// The study deployment id for the currently running deployment.
//   /// Returns the deployment id cached locally on the phone (if available).
//   /// Returns `null` if no study is deployed (yet).
//   String? get studyDeploymentId => (_studyDeploymentId ??=
//       Settings().preferences?.getString(STUDY_DEPLOYMENT_ID_KEY));

//   /// Set the study deployment id for the currently running deployment.
//   /// This study deployment id will be cached locally on the phone.
//   set studyDeploymentId(String? id) {
//     assert(
//         id != null,
//         'Cannot set the study deployment id to null in Settings. '
//         "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
//     _studyDeploymentId = id;
//     Settings().preferences?.setString(STUDY_DEPLOYMENT_ID_KEY, id!);
//   }

//   /// The device role name for the currently running deployment.
//   ///
//   /// The role name is cached locally on the phone.
//   /// Returns `null` if no study is deployed (yet).
//   String? get deviceRoleName => (_deviceRoleName ??=
//       Settings().preferences?.getString(DEVICE_ROLE_NAME_KEY));

//   set deviceRoleName(String? roleName) {
//     assert(
//         roleName != null,
//         'Cannot set device role name to null in Settings. '
//         "Use the 'eraseStudyDeployment()' method to erase study deployment information.");
//     _deviceRoleName = roleName;
//     Settings().preferences?.setString(DEVICE_ROLE_NAME_KEY, roleName!);
//   }

//   /// Use the cached study deployment?
//   bool get useCachedStudyDeployment => _useCached;

//   /// Should sensing be automatically resumed on app startup?
//   bool get resumeSensingOnStartup => _resumeSensingOnStartup;

//   /// Erase all study deployment information cached locally on this phone.
//   Future<void> eraseStudyDeployment() async {
//     _studyDeploymentId = null;
//     await Settings().preferences!.remove(STUDY_DEPLOYMENT_ID_KEY);
//   }

//   /// The [SmartphoneDeployment] deployed on this phone.
//   SmartphoneDeployment? get deployment => bloc.sensing.controller?.deployment;

//   /// The preferred format of the data to be uploaded according to
//   /// [NameSpace]. Default using the [NameSpace.CARP].
//   String dataFormat = NameSpace.CARP;

//   /// Initialize the BLoC.
//   Future<void> initialize({
//     String? deploymentId,
//     String dataFormat = NameSpace.CARP,
//     bool useCachedStudyDeployment = true,
//     bool resumeSensingOnStartup = false,
//   }) async {
//     await Settings().init();
//     Settings().debugLevel = DebugLevel.debug;
//     if (deploymentId != null) studyDeploymentId = deploymentId;
//     this.dataFormat = dataFormat;
//     _resumeSensingOnStartup = resumeSensingOnStartup;
//     _useCached = useCachedStudyDeployment;

//     info('$runtimeType initialized');
//   }

//   void start() {
//     SmartPhoneClientManager().notificationController?.createNotification(
//           title: 'Sensing Started',
//           body:
//               'Data sampling is now running in the background. Click the STOP button to stop sampling again.',
//         );
//     SmartPhoneClientManager().start();
//   }

//   void stop() {
//     SmartPhoneClientManager().notificationController?.createNotification(
//           title: 'Sensing Stopped',
//           body:
//               'Sampling is stopped and no more data will be collected. Click the START button to restart sampling.',
//         );
//     SmartPhoneClientManager().stop();
//   }

//   void dispose() => SmartPhoneClientManager().dispose();

//   /// Is sensing running, i.e. has the study executor been started?
//   bool get isRunning =>
//       SmartPhoneClientManager().state == ClientManagerState.started;
// }
