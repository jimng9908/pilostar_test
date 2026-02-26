import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required super.id,
    required super.name,
    required super.address,
    required super.phone,
    required super.email,
    required super.website,
    required super.organizationId,
    required super.isActive,
    required super.createdAt,
  });

  CompanyModel.fromEntity(Company responseCompany)
      : this(
          id: responseCompany.id,
          name: responseCompany.name,
          address: responseCompany.address,
          phone: responseCompany.phone,
          email: responseCompany.email,
          website: responseCompany.website,
          organizationId: responseCompany.organizationId,
          isActive: responseCompany.isActive,
          createdAt: responseCompany.createdAt,
        );

  Company toEntity() {
    return Company(
      id: id,
      name: name,
      address: address,
      phone: phone,
      email: email,
      website: website,
      organizationId: organizationId,
      isActive: isActive,
      createdAt: createdAt,
    );
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      email: json["email"],
      website: json["website"],
      organizationId:
          json["organization"] != null ? json["organization"]['id'] : null,
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "email": email,
        "website": website,
        "organization": {
          "id": organizationId,
        },
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        phone,
        email,
        website,
        organizationId,
        isActive,
        createdAt,
      ];
}
