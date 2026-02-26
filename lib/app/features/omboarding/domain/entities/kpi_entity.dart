import 'package:equatable/equatable.dart';

class KpiEntity extends Equatable {
  const KpiEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.dataSourceId,
    required this.dataSource,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final dynamic description;
  final int? dataSourceId;
  final DataSourceEntity? dataSource;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        dataSourceId,
        dataSource,
        createdAt,
      ];
}

class DataSourceEntity extends Equatable {
  const DataSourceEntity({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
