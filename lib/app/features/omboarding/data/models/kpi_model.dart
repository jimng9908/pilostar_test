import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class KpiModel extends KpiEntity {
    const KpiModel({
        required super.id,
        required super.name,
        required super.description,
        required super.dataSourceId,
        required super.dataSource,
        required super.createdAt,
    });

    factory KpiModel.fromJson(Map<String, dynamic> json){ 
        return KpiModel(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            dataSourceId: json["dataSourceId"],
            dataSource: json["dataSource"] == null ? null : DataSourceModel.fromJson(json["dataSource"]),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "dataSourceId": dataSourceId,
        "dataSource": (dataSource as DataSourceModel).toJson(),
        "createdAt": createdAt?.toIso8601String(),
    };

    @override
    List<Object?> get props => [
    id, name, description, dataSourceId, dataSource, createdAt, ];
}

class DataSourceModel extends DataSourceEntity {
    const DataSourceModel({
        required super.id,
        required super.name,
    });

    factory DataSourceModel.fromJson(Map<String, dynamic> json){ 
        return DataSourceModel(
            id: json["id"],
            name: json["name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };

    @override
    List<Object?> get props => [
    id, name, ];
}
