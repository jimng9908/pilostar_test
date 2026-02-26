import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ResponseAutoConfig extends Equatable {
  final int? id;
  final String? name;
  final dynamic description;
  final String? address;
  final String? phone;
  final dynamic email;
  final String? type;
  final String? gmbLocationId;
  final bool? isActive;
  final bool? delivery;
  final bool? takeaway;
  final List<ServiceHour> serviceHours;
  final dynamic cep;
  final dynamic website;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final int? totalReviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Company? company;
  final Organization? organization;
  final bool? hasTerrace;
  final int? terraceTables;
  final int? terraceChairs;
  final int? interiorTables;
  final int? interiorChairs;

  const ResponseAutoConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    required this.type,
    required this.gmbLocationId,
    required this.isActive,
    required this.delivery,
    required this.takeaway,
    required this.serviceHours,
    required this.cep,
    required this.website,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.totalReviews,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.organization,
    required this.hasTerrace,
    required this.terraceTables,
    required this.terraceChairs,
    required this.interiorTables,
    required this.interiorChairs,
  });

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

class ServiceHour extends Equatable {
  final String? day;
  final String? hours;
  
  const ServiceHour({
    required this.day,
    required this.hours,
  });

  @override
  List<Object?> get props => [
        day,
        hours,
      ];
}
