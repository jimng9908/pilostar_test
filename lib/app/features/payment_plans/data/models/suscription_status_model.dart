import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class SuscriptionStatusModel extends SubscriptionStatusEntity {
  const SuscriptionStatusModel({
    required super.hasActivePlan,
    super.plan,
    super.endDate,
    required super.daysRemaining,
  });

  factory SuscriptionStatusModel.fromEntity(SubscriptionStatusEntity entity) {
    return SuscriptionStatusModel(
      hasActivePlan: entity.hasActivePlan,
      plan: entity.plan,
      endDate: entity.endDate,
      daysRemaining: entity.daysRemaining,
    );
  }

  SubscriptionStatusEntity toEntity() {
    return SubscriptionStatusEntity(
      hasActivePlan: hasActivePlan,
      plan: plan,
      endDate: endDate,
      daysRemaining: daysRemaining,
    );
  }

  factory SuscriptionStatusModel.fromJson(Map<String, dynamic> json) {
    return SuscriptionStatusModel(
      hasActivePlan: json['hasActivePlan'],
      plan: json['plan'],
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      daysRemaining: json['daysRemaining'],
    );
  }

  @override
  List<Object?> get props => [
        hasActivePlan,
        plan,
        endDate,
        daysRemaining,
      ];
}
