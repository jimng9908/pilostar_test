import 'package:equatable/equatable.dart';

class BusinessInformation extends Equatable {
  const BusinessInformation({
    required this.placeId,
    required this.name,
    required this.formattedAddress,
    required this.rating,
    required this.userRatingsTotal,
    required this.geometry,
    required this.phone,
    required this.website,
    required this.categories,
    required this.openingHours,
  });

  final String? placeId;
  final String? name;
  final String? formattedAddress;
  final double? rating;
  final int? userRatingsTotal;
  final Geometry? geometry;
  final String? phone;
  final String? website;
  final List<String> categories;
  final List<OpeningHour> openingHours;

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

class Geometry extends Equatable {
  const Geometry({
    required this.location,
  });

  final Location? location;

  @override
  List<Object?> get props => [
        location,
      ];
}

class Location extends Equatable {
  const Location({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  @override
  List<Object?> get props => [
        lat,
        lng,
      ];
}

class OpeningHour extends Equatable {
  const OpeningHour({
    required this.day,
    required this.hours,
  });

  final String? day;
  final String? hours;

  @override
  List<Object?> get props => [
        day,
        hours,
      ];
}
