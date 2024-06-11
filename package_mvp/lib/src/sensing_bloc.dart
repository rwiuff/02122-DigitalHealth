// lib/src/sensing_bloc/sensing_bloc.dart

import 'package:flutter/material.dart';
import 'package:package_mvp/src/sensing.dart';
import 'package:package_mvp/src/carp_service.dart';

class SensingBLoC {
  static const String STUDY_ID_KEY = 'study_id';
  static const String STUDY_DEPLOYMENT_ID_KEY = 'study_deployment_id';
  static const String DEVICE_ROLE_NAME_KEY = 'device_role_name';

  bool _useCached = true;
  bool _resumeSensingOnStartup = false;

  Sensing get sensing => Sensing();

  DeploymentMode deploymentMode = DeploymentMode.local;

  String? get studyId => CarpService().studyDeploymentId;

  set studyId(String? id) {
    assert(id != null, 'Cannot set the study id to null in Settings.');
    CarpService().studyDeploymentId = id;
    _setToPreferences(STUDY_ID_KEY, id!);
  }

  String? get studyDeploymentId => CarpService().studyDeploymentId;

  set studyDeploymentId(String? id) {
    assert(id != null, 'Cannot set the study deployment id to null in Settings.');
    CarpService().studyDeploymentId = id;
    _setToPreferences(STUDY_DEPLOYMENT_ID_KEY, id!);
  }

  String? get deviceRoleName => CarpService().deviceRoleName;

  set deviceRoleName(String? name) {
    assert(name != null, 'Cannot set the device role name to null in Settings.');
    CarpService().deviceRoleName = name;
    _setToPreferences(DEVICE_ROLE_NAME_KEY, name!);
  }

  void eraseStudyDeployment() {
    CarpService().studyDeploymentId = null;
    CarpService().deviceRoleName = null;
    _removeFromPreferences(STUDY_ID_KEY);
    _removeFromPreferences(STUDY_DEPLOYMENT_ID_KEY);
    _removeFromPreferences(DEVICE_ROLE_NAME_KEY);
  }

  bool get useCachedStudyDeployment => _useCached;

  bool get resumeSensingOnStartup => _resumeSensingOnStartup;

  Future<void> initialize({
    DeploymentMode deploymentMode = DeploymentMode.local,
    String? deploymentId,
    bool useCachedStudyDeployment = true,
    bool resumeSensingOnStartup = false,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.deploymentMode = deploymentMode;
    if (deploymentId != null) studyDeploymentId = deploymentId;
    _resumeSensingOnStartup = resumeSensingOnStartup;
    _useCached = useCachedStudyDeployment;

    debugPrint('$runtimeType initialized');
  }

  void start() {
    Sensing().start();
  }

  void stop() {
    Sensing().stop();
  }

  void dispose() => Sensing().dispose();

  bool get isRunning => Sensing().isRunning;

  Future<String?> _getFromPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<void> _setToPreferences(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  Future<void> _removeFromPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }
}

class SharedPreferences {
  static getInstance() {}
  
  remove(String key) {}
  
  setString(String key, String value) {}
  
  Future<String?> getString(String key) {
    throw getString(key);
  }
}
