import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class RequestKpiPreferencesModel extends RequestKpiPreferences {
    const RequestKpiPreferencesModel({
        required super.kpiId,
        required super.isActive,
    });

    factory RequestKpiPreferencesModel.fromEntity(RequestKpiPreferences requestKpiPreferences){ 
        return RequestKpiPreferencesModel(
            kpiId: requestKpiPreferences.kpiId,
            isActive: requestKpiPreferences.isActive,
        );
    }

    RequestKpiPreferences toEntity() => RequestKpiPreferences(
        kpiId: kpiId,
        isActive: isActive,
    );

    factory RequestKpiPreferencesModel.fromJson(Map<String, dynamic> json){ 
        return RequestKpiPreferencesModel(
            kpiId: json["kpiId"],
            isActive: json["isActive"],
        );
    }

    Map<String, dynamic> toJson() => {
        "kpiId": kpiId,
        "isActive": isActive,
    };

    @override
    List<Object?> get props => [kpiId, isActive];
}