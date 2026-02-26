import 'package:equatable/equatable.dart';

class ProfileVenueConfig extends Equatable {
  final int totalTables;
  final int totalCapacity;
  final bool hasTerrace;
  final int interiorTables;
  final int interiorCapacity;
  final int terraceTables;
  final int terraceCapacity;

  const ProfileVenueConfig({
    required this.totalTables,
    required this.totalCapacity,
    required this.hasTerrace,
    required this.interiorTables,
    required this.interiorCapacity,
    required this.terraceTables,
    required this.terraceCapacity,
  });

  @override
  List<Object?> get props => [
        totalTables,
        totalCapacity,
        hasTerrace,
        interiorTables,
        interiorCapacity,
        terraceTables,
        terraceCapacity,
      ];

  ProfileVenueConfig copyWith({
    int? totalTables,
    int? totalCapacity,
    bool? hasTerrace,
    int? interiorTables,
    int? interiorCapacity,
    int? terraceTables,
    int? terraceCapacity,
  }) {
    return ProfileVenueConfig(
      totalTables: totalTables ?? this.totalTables,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      hasTerrace: hasTerrace ?? this.hasTerrace,
      interiorTables: interiorTables ?? this.interiorTables,
      interiorCapacity: interiorCapacity ?? this.interiorCapacity,
      terraceTables: terraceTables ?? this.terraceTables,
      terraceCapacity: terraceCapacity ?? this.terraceCapacity,
    );
  }
}
