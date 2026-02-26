import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class RequestAutoConfigModel extends RequestAutoConfig {
  const RequestAutoConfigModel({
    required super.placeId,
    required super.venueType,
    required super.userId,
    required super.hasTerrace,
    required super.terraceTables,
    required super.terraceChairs,
    required super.interiorTables,
    required super.interiorChairs,
    required super.delivery,
    required super.takeaway,
  });

  factory RequestAutoConfigModel.fromEntity(RequestAutoConfig entity) {
    return RequestAutoConfigModel(
      placeId: entity.placeId,
      venueType: entity.venueType,
      userId: entity.userId,
      hasTerrace: entity.hasTerrace,
      terraceTables: entity.terraceTables,
      terraceChairs: entity.terraceChairs,
      interiorTables: entity.interiorTables,
      interiorChairs: entity.interiorChairs,
      delivery: entity.delivery,
      takeaway: entity.takeaway,
    );
  }

  factory RequestAutoConfigModel.fromJson(Map<String, dynamic> json) {
    return RequestAutoConfigModel(
      placeId: json["placeId"],
      venueType: json["venueType"],
      userId: json["userId"],
      hasTerrace: json["hasTerrace"],
      terraceTables: json["terraceTables"],
      terraceChairs: json["terraceChairs"],
      interiorTables: json["interiorTables"],
      interiorChairs: json["interiorChairs"],
      delivery: json["delivery"],
      takeaway: json["takeaway"],
    );
  }

  Map<String, dynamic> toJson() => {
        "placeId": placeId,
        "venueType": venueType,
        "userId": userId,
        "hasTerrace": hasTerrace,
        "terraceTables": terraceTables,
        "terraceChairs": terraceChairs,
        "interiorTables": interiorTables,
        "interiorChairs": interiorChairs,
        "delivery": delivery,
        "takeaway": takeaway,
      };

  @override
  List<Object?> get props => [
        placeId,
        venueType,
        userId,
        hasTerrace,
        terraceTables,
        terraceChairs,
        interiorTables,
        interiorChairs,
        delivery,
        takeaway,
      ];
}
