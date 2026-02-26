import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class BusinessInformationModel extends BusinessInformation {
  const BusinessInformationModel({
    required super.placeId,
    required super.name,
    required super.formattedAddress,
    required super.rating,
    required super.userRatingsTotal,
    required super.geometry,
    required super.phone,
    required super.website,
    required super.categories,
    required super.openingHours,
  });

  factory BusinessInformationModel.fromJson(Map<String, dynamic> json) {
    return BusinessInformationModel(
      placeId: json["place_id"],
      name: json["name"],
      formattedAddress: json["formatted_address"],
      rating: (json["rating"] as num?)?.toDouble(),
      userRatingsTotal: json["user_ratings_total"],
      geometry: json["geometry"] == null
          ? null
          : GeometryModel.fromJson(json["geometry"]),
      phone: json["phone"],
      website: json["website"],
      categories: json["categories"] == null
          ? []
          : List<String>.from(json["categories"]!.map((x) => x)),
      openingHours: json["openingHours"] == null
          ? []
          : List<OpeningHourModel>.from(
              json["openingHours"]!.map((x) => OpeningHourModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "name": name,
        "formatted_address": formattedAddress,
        "rating": rating,
        "user_ratings_total": userRatingsTotal,
        "geometry": (geometry as GeometryModel).toJson(),
        "phone": phone,
        "website": website,
        "categories": categories.map((x) => x).toList(),
        "openingHours":
            openingHours.map((x) => (x as OpeningHourModel).toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        placeId,
        name,
        formattedAddress,
        rating,
        userRatingsTotal,
        geometry,
        phone,
        website,
        categories,
        openingHours,
      ];
}

class GeometryModel extends Geometry {
  const GeometryModel({
    required super.location,
  });

  factory GeometryModel.fromJson(Map<String, dynamic> json) {
    return GeometryModel(
      location: json["location"] == null
          ? null
          : LocationModel.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "location": (location as LocationModel).toJson(),
      };

  @override
  List<Object?> get props => [
        location,
      ];
}

class LocationModel extends Location {
  const LocationModel({
    required super.lat,
    required super.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: (json["lat"] as num?)?.toDouble(),
      lng: (json["lng"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  @override
  List<Object?> get props => [
        lat,
        lng,
      ];
}

class OpeningHourModel extends OpeningHour {
  const OpeningHourModel({
    required super.day,
    required super.hours,
  });

  factory OpeningHourModel.fromJson(Map<String, dynamic> json) {
    return OpeningHourModel(
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
