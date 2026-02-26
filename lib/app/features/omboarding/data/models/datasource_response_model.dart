import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class DatasourceResponseModel extends DatasourcesResponse {
  const DatasourceResponseModel({
    required super.id,
    super.apiKey,
    super.token,
    required super.userId,
    required super.sourceId,
    super.email,
    super.password,
  });

  factory DatasourceResponseModel.fromJson(Map<String, dynamic> json) {
    return DatasourceResponseModel(
      id: json['id'],
      apiKey: json['apiKey'],
      token: json['token'],
      userId: json['userId'],
      sourceId: json['dataSourceId'],
      email: json['email'],
      password: json['password'],
    );
  }

  factory DatasourceResponseModel.fromEntity(DatasourcesResponse entity) {
    return DatasourceResponseModel(
      id: entity.id,
      apiKey: entity.apiKey,
      token: entity.token,
      userId: entity.userId,
      sourceId: entity.sourceId,
      email: entity.email,
      password: entity.password,
    );
  }

  DatasourcesResponse toEntity() {
    return DatasourcesResponse(
      id: id,
      apiKey: apiKey,
      token: token,
      userId: userId,
      sourceId: sourceId,
      email: email,
      password: password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apiKey': apiKey,
      'token': token,
      'userId': userId,
      'sourceId': sourceId,
      'email': email,
      'password': password,
    };
  }
}
