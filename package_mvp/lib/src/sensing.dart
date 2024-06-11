// lib/src/sensing/sensing.dart

import 'package:flutter/material.dart';
import 'package:package_mvp/src/carp_service.dart';

class Sensing {
  static final Sensing _instance = Sensing._();
  factory Sensing() => _instance;

  Sensing._();

  bool _isRunning = false;
  bool _isDisposed = false;

  Future<void> initialize() async {
    debugPrint('Initializing Sensing - mode: ${CarpService().deploymentMode}');

    // Simulate initialization logic
    CarpService().studyDeploymentId = 'example_study_deployment_id';
    CarpService().deviceRoleName = 'example_device_role_name';

    debugPrint('Sensing initialized with studyDeploymentId: ${CarpService().studyDeploymentId} and deviceRoleName: ${CarpService().deviceRoleName}');
  }

  void start() {
    if (_isDisposed) {
      throw StateError('Cannot start a disposed sensor');
    }
    _isRunning = true;
    debugPrint('Sensing started');
  }

  void stop() {
    _isRunning = false;
    debugPrint('Sensing stopped');
  }

  void dispose() {
    _isRunning = false;
    _isDisposed = true;
    debugPrint('Sensing disposed');
  }

  bool get isRunning => _isRunning;
}
