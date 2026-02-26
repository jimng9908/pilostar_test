import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ResponseVenueModel extends ResponseVenue {
  const ResponseVenueModel({
    required super.id,
    required super.name,
    required super.companyId,
    required super.organizationId,
    required super.type,
    required super.isActive,
    required super.delivery,
    required super.takeaway,
    required super.createdAt,
  });

  ResponseVenueModel fromEntity(ResponseVenue entity) {
    return ResponseVenueModel(
      id: entity.id,
      name: entity.name,
      companyId: entity.companyId,
      organizationId: entity.organizationId,
      type: entity.type,
      isActive: entity.isActive,
      delivery: entity.delivery,
      takeaway: entity.takeaway,
      createdAt: entity.createdAt,
    );
  }

  ResponseVenue toEntity() {
    return ResponseVenue(
      id: id,
      name: name,
      companyId: companyId,
      organizationId: organizationId,
      type: type,
      isActive: isActive,
      delivery: delivery,
      takeaway: takeaway,
      createdAt: createdAt,
    );
  }

  factory ResponseVenueModel.fromJson(Map<String, dynamic> json) {
    return ResponseVenueModel(
      id: json["id"],
      name: json["name"],
      companyId: json["company"]['id'],
      organizationId: json["organization"]['id'],
      type: json["type"],
      isActive: json["isActive"],
      delivery: json["delivery"],
      takeaway: json["takeaway"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "companyId": companyId,
        "organizationId": organizationId,
        "type": type,
        "isActive": isActive,
        "delivery": delivery,
        "takeaway": takeaway,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        name,
        companyId,
        organizationId,
        type,
        isActive,
        delivery,
        takeaway,
        createdAt,
      ];
}
