import 'package:equatable/equatable.dart';

class ProfileDataSource extends Equatable {
  final String id;
  final String title;
  final String description;
  final String status;
  final String lastSync;
  final String kpis;
  final bool isRequired;
  final bool hasUnlink;
  final List<DataSourceKpi> kpisList;

  const ProfileDataSource({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.lastSync,
    required this.kpis,
    this.isRequired = false,
    this.hasUnlink = false,
    this.kpisList = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        lastSync,
        kpis,
        isRequired,
        hasUnlink,
        kpisList,
      ];
}

class DataSourceKpi extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isActive;

  const DataSourceKpi({
    required this.id,
    required this.title,
    required this.description,
    this.isActive = false,
  });

  DataSourceKpi copyWith({
    String? id,
    String? title,
    String? description,
    bool? isActive,
  }) {
    return DataSourceKpi(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [id, title, description, isActive];
}

class DataSourcesSummary extends Equatable {
  final int connectedCount;
  final int totalCount;
  final int totalKpis;
  final String lastSync;

  const DataSourcesSummary({
    required this.connectedCount,
    required this.totalCount,
    required this.totalKpis,
    required this.lastSync,
  });

  @override
  List<Object?> get props => [
        connectedCount,
        totalCount,
        totalKpis,
        lastSync,
      ];
}
