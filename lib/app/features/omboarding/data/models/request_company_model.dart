import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class RequestCompanyModel extends RequestCompany {
  const RequestCompanyModel({
    required super.name,
    required super.address,
    required super.phone,
    required super.email,
    required super.website,
    required super.organizationId,
  });

  factory RequestCompanyModel.fromEntity(RequestCompany entity) {
    return RequestCompanyModel(
      name: entity.name,
      address: entity.address,
      phone: entity.phone,
      email: entity.email,
      website: entity.website,
      organizationId: entity.organizationId,
    );
  }

  RequestCompany toEntity() {
    return RequestCompany(
      name: name,
      address: address,
      phone: phone,
      email: email,
      website: website,
      organizationId: organizationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'organizationId': organizationId,
    };
  }
}
