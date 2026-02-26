import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class SubscriptionStatusModel extends SubscriptionStatusEntity {
  const SubscriptionStatusModel({
    required super.hasActivePlan,
    super.plan,
    super.endDate,
    required super.daysRemaining,
  });

  factory SubscriptionStatusModel.fromEntity(SubscriptionStatusEntity entity) {
    return SubscriptionStatusModel(
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

  factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatusModel(
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
