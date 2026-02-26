import 'package:equatable/equatable.dart';

class RequestVenue extends Equatable {
  final String? name;
  final int? companyId;
  final int? organizationId;
  final String? type;
  final bool? isActive;
  final bool? local;
  final bool? delivery;
  final bool? takeaway;
  final ServiceHours? serviceHours;
  final String? zoneCode;
  final String? municipalityCode;

  const RequestVenue({
    required this.name,
    required this.companyId,
    required this.organizationId,
    required this.type,
    required this.isActive,
    required this.local,
    required this.delivery,
    required this.takeaway,
    required this.serviceHours,
    required this.zoneCode,
    required this.municipalityCode,
  });

  @override
  List<Object?> get props => [
        name,
        companyId,
        organizationId,
        type,
        isActive,
        delivery,
        takeaway,
        serviceHours,
        zoneCode,
        municipalityCode,
      ];
}

class ServiceHours extends Equatable {
  final dynamic json;
  const ServiceHours({required this.json});

  @override
  List<Object?> get props => [json];
}
