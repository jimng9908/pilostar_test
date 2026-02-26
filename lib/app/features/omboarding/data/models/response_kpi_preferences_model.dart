import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ResponseKpiPreferencesModel extends ResponseKpiPreferences {
    const ResponseKpiPreferencesModel({
        required super.id,
        required super.kpiId,
        required super.kpiName,
        required super.isActive,
    });

    factory ResponseKpiPreferencesModel.fromJson(Map<String, dynamic> json){ 
        return ResponseKpiPreferencesModel(
            id: json["id"],
            kpiId: json["kpiId"],
            kpiName: json["kpiName"],
            isActive: json["isActive"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "kpiId": kpiId,
        "kpiName": kpiName,
        "isActive": isActive,
    };

    @override
    List<Object?> get props => [
    id, kpiId, kpiName, isActive, ];
}
