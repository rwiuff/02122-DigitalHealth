// lib/src/backend/backend.dart

import 'package:flutter/material.dart';
import 'package:package_mvp/src/carp_service.dart';

class CarpBackend {
  static const String HOST_URI = "example.com"; // Placeholder URI

  static const Map<DeploymentMode, String> uris = {
    DeploymentMode.development: 'dev',
    DeploymentMode.staging: 'stage',
    DeploymentMode.production: '',
  };

  static final CarpBackend _instance = CarpBackend._();
  CarpBackend._();
  factory CarpBackend() => _instance;

  String? get user => CarpService().currentUser;

  String? get username => CarpService().currentUser;

  Uri get uri => Uri(
        scheme: 'https',
        host: HOST_URI,
        pathSegments: [
          'auth',
          uris[CarpService().deploymentMode]!,
        ],
      );

  Future<void> initialize() async {
    Map<String, String> config = {
      'name': 'Example App - ${CarpService().deploymentMode.name}',
      'uri': uri.toString(),
    };

    await CarpService().configure(config);

    debugPrint('$runtimeType initialized');
  }

  Future<String> authenticate(String username, String password) async {
    return await CarpService().authenticate(username, password);
  }

  Future<void> getStudyInvitation(BuildContext context) async {
    // Placeholder for getting study invitation logic
    // For example, fetching from a REST API
    CarpService().studyId = 'example_study_id';
    CarpService().studyDeploymentId = 'example_deployment_id';
    CarpService().deviceRoleName = 'example_device_role';

    debugPrint('Invitation received - '
        'study id: ${CarpService().studyId}, '
        'deployment id: ${CarpService().studyDeploymentId}, '
        'role name: ${CarpService().deviceRoleName}');
  }
}
