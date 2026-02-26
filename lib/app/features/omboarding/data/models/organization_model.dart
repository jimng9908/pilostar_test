import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class OrganizationModel extends Organization {
    const OrganizationModel({
        required super.id,
        required super.name,
        required super.nif,
        required super.isActive,
        required super.createdAt,
    });

    factory OrganizationModel.fromJson(Map<String, dynamic> json){ 
        return OrganizationModel(
            id: json["id"],
            name: json["name"],
            nif: json["nif"],
            isActive: json["isActive"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
        );
    }

    OrganizationModel fromEntity(Organization entity){
        return OrganizationModel(
            id: entity.id,
            name: entity.name,
            nif: entity.nif,
            isActive: entity.isActive,
            createdAt: entity.createdAt,
        );
    }

    Organization toEntity() => Organization(
        id: id,
        name: name,
        nif: nif,
        isActive: isActive,
        createdAt: createdAt,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nif": nif,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    id, name, nif, isActive, createdAt, ];
}
