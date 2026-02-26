import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class DatasourceRequestModel extends DatasourceRequest {
  const DatasourceRequestModel({
    required super.dataSourceId,
    super.apiKey,
    super.token,
    super.email,
    super.password,
  });

  factory DatasourceRequestModel.fromEntity(DatasourceRequest entity) {
    return DatasourceRequestModel(
      dataSourceId: entity.dataSourceId,
      apiKey: entity.apiKey,
      token: entity.token,
      email: entity.email,
      password: entity.password,
    );
  }

  DatasourceRequest toEntity() {
    return DatasourceRequest(
      dataSourceId: dataSourceId,
      apiKey: apiKey,
      token: token,
      email: email,
      password: password,
    );
  }

  factory DatasourceRequestModel.fromJson(Map<String, dynamic> json) {
    return DatasourceRequestModel(
      dataSourceId: json['dataSourceId'],
      apiKey: json['apiKey'],
      token: json['token'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataSourceId': dataSourceId,
      'apiKey': apiKey,
      'token': token,
      'email': email,
      'password': password,
    };
  }
}