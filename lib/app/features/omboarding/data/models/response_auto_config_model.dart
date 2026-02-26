import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ResponseAutoConfigModel extends ResponseAutoConfig {
  const ResponseAutoConfigModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    required super.phone,
    required super.email,
    required super.type,
    required super.gmbLocationId,
    required super.isActive,
    required super.delivery,
    required super.takeaway,
    required super.serviceHours,
    required super.cep,
    required super.website,
    required super.latitude,
    required super.longitude,
    required super.rating,
    required super.totalReviews,
    required super.createdAt,
    required super.updatedAt,
    required super.company,
    required super.organization,
    required super.hasTerrace,
    required super.terraceTables,
    required super.terraceChairs,
    required super.interiorTables,
    required super.interiorChairs,
  });

  factory ResponseAutoConfigModel.fromJson(Map<String, dynamic> json) {
    return ResponseAutoConfigModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      address: json["address"],
      phone: json["phone"],
      email: json["email"],
      type: json["type"],
      gmbLocationId: json["gmbLocationId"],
      isActive: json["isActive"],
      delivery: json["delivery"],
      takeaway: json["takeaway"],
      serviceHours: json["serviceHours"] == null
          ? []
          : List<ServiceHourModel>.from(
              json["serviceHours"]!.map((x) => ServiceHourModel.fromJson(x))),
      cep: json["cep"],
      website: json["website"],
      latitude: (json["latitude"] as num?)?.toDouble(),
      longitude: (json["longitude"] as num?)?.toDouble(),
      rating: (json["rating"] as num?)?.toDouble(),
      totalReviews: json["totalReviews"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      company: json["company"] == null
          ? null
          : CompanyModel.fromJson(json["company"]),
      organization: json["organization"] == null
          ? null
          : OrganizationModel.fromJson(json["organization"]),
      hasTerrace: json["hasTerrace"],
      terraceTables: json["terraceTables"],
      terraceChairs: json["terraceChairs"],
      interiorTables: json["interiorTables"],
      interiorChairs: json["interiorChairs"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "address": address,
        "phone": phone,
        "email": email,
        "type": type,
        "gmbLocationId": gmbLocationId,
        "isActive": isActive,
        "delivery": delivery,
        "takeaway": takeaway,
        "serviceHours":
            serviceHours.map((x) => (x as ServiceHourModel).toJson()).toList(),
        "cep": cep,
        "website": website,
        "latitude": latitude,
        "longitude": longitude,
        "rating": rating,
        "totalReviews": totalReviews,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "company": (company as CompanyModel).toJson(),
        "organization": (organization as OrganizationModel).toJson(),
        "hasTerrace": hasTerrace,
        "terraceTables": terraceTables,
        "terraceChairs": terraceChairs,
        "interiorTables": interiorTables,
        "interiorChairs": interiorChairs,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        address,
        phone,
        email,
        type,
        gmbLocationId,
        isActive,
        delivery,
        takeaway,
        serviceHours,
        cep,
        website,
        latitude,
        longitude,
        rating,
        totalReviews,
        createdAt,
        updatedAt,
        company,
        organization,
        hasTerrace,
        terraceTables,
        terraceChairs,
        interiorTables,
        interiorChairs,
      ];
}

class ServiceHourModel extends ServiceHour {
  const ServiceHourModel({
    required super.day,
    required super.hours,
  });

  factory ServiceHourModel.fromJson(Map<String, dynamic> json) {
    return ServiceHourModel(
      day: json["day"],
      hours: json["hours"],
    );
  }

  Map<String, dynamic> toJson() => {
        "day": day,
        "hours": hours,
      };

  @override
  List<Object?> get props => [
        day,
        hours,
      ];
}
