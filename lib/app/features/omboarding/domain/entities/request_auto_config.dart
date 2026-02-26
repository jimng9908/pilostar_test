import 'package:equatable/equatable.dart';

class RequestAutoConfig extends Equatable {
  const RequestAutoConfig({
    required this.placeId,
    required this.venueType,
    required this.userId,
    required this.hasTerrace,
    required this.terraceTables,
    required this.terraceChairs,
    required this.interiorTables,
    required this.interiorChairs,
    required this.delivery,
    required this.takeaway,
  });

  final String? placeId;
  final String? venueType;
  final int? userId;
  final bool? hasTerrace;
  final int? terraceTables;
  final int? terraceChairs;
  final int? interiorTables;
  final int? interiorChairs;
  final bool? delivery;
  final bool? takeaway;

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
