import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class RequestVenueModel extends RequestVenue {
  const RequestVenueModel({
    required super.name,
    required super.companyId,
    required super.organizationId,
    required super.type,
    required super.isActive,
    required super.local,
    required super.delivery,
    required super.takeaway,
    required super.serviceHours,
    required super.zoneCode,
    required super.municipalityCode,
  });

  factory RequestVenueModel.fromEntity(RequestVenue entity) {
    return RequestVenueModel(
      name: entity.name,
      companyId: entity.companyId,
      organizationId: entity.organizationId,
      type: entity.type,
      isActive: entity.isActive,
      local: entity.local,
      delivery: entity.delivery,
      takeaway: entity.takeaway,
      serviceHours: entity.serviceHours,
      zoneCode: entity.zoneCode,
      municipalityCode: entity.municipalityCode,
    );
  }

  RequestVenue toEntity() {
    return RequestVenue(
      name: name,
      companyId: companyId,
      organizationId: organizationId,
      type: type,
      isActive: isActive,
      local: local,
      delivery: delivery,
      takeaway: takeaway,
      serviceHours: serviceHours,
      zoneCode: zoneCode,
      municipalityCode: municipalityCode,
    );
  }

  factory RequestVenueModel.fromJson(Map<String, dynamic> json) {
    return RequestVenueModel(
      name: json["name"],
      companyId: json["companyId"],
      organizationId: json["organizationId"],
      type: json["type"],
      isActive: json["isActive"],
      local: json["dine_in"],
      delivery: json["delivery"],
      takeaway: json["takeaway"],
      serviceHours: json["serviceHours"] == null
          ? null
          : ServiceHoursModel.fromJson(json["serviceHours"]),
      zoneCode: json["zoneCode"],
      municipalityCode: json["municipalityCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "companyId": companyId,
        "organizationId": organizationId,
        "type": type,
        "isActive": isActive,
        "dine_in": local,
        "delivery": delivery,
        "takeaway": takeaway,
        "serviceHours": serviceHours?.json,
        "zoneCode": zoneCode,
        "municipalityCode": municipalityCode,
      };

  @override
  List<Object?> get props => [
        name,
        companyId,
        organizationId,
        type,
        isActive,
        local,
        delivery,
        takeaway,
        serviceHours,
        zoneCode,
        municipalityCode,
      ];
}

class ServiceHoursModel extends ServiceHours {
  const ServiceHoursModel({required super.json});

  factory ServiceHoursModel.fromJson(dynamic json) {
    return ServiceHoursModel(json: json);
  }

  dynamic toJson() => json;

  @override
  List<Object?> get props => [json];
}
