part of '../main.dart';

class Data_endpoint {
  static const String dataIdKey = 'data_id';
  static const String dataDeploymentIdKey = 'data_deployment_id';
  static const String dataRoleNameKey = 'device_role_name';

  String? _dataId;
  String? _dataDeploymentId;
  String? _deviceRoleName;


   String? get dataid =>
      (_dataId ??= Settings().preferences?.getString(dataIdKey));

  String? set dataDeploymentId =>
    (_dataDeploymentID ??= Settings().preferences?.getString(_dataDeploymentId));
  }

  void data_endpoint() {
    return 
  }
}