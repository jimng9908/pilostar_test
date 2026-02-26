import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class FreeTrialModel extends FreeTrialEntity {
  const FreeTrialModel({
    required super.id,
    required super.user,
    required super.plan,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.stripeSubscriptionId,
    required super.createdAt,
  });

  factory FreeTrialModel.fromEntity(FreeTrialEntity entity) {
    return FreeTrialModel(
      id: entity.id,
      user: entity.user,
      plan: entity.plan,
      startDate: entity.startDate,
      endDate: entity.endDate,
      status: entity.status,
      stripeSubscriptionId: entity.stripeSubscriptionId,
      createdAt: entity.createdAt,
    );
  }

  FreeTrialEntity toEntity() {
    return FreeTrialEntity(
      id: id,
      user: user,
      plan: plan,
      startDate: startDate,
      endDate: endDate,
      status: status,
      stripeSubscriptionId: stripeSubscriptionId,
      createdAt: createdAt,
    );
  }

  factory FreeTrialModel.fromJson(Map<String, dynamic> json) {
    return FreeTrialModel(
      id: json['id'],
      user: RegisterResponseModel.fromJson(json['user']),
      plan: PlanModel.fromJson(json['plan']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      stripeSubscriptionId: json['stripeSubscriptionId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': (user as RegisterResponseModel).toJson(),
      'plan': (plan as PlanModel).toJson(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'stripeSubscriptionId': stripeSubscriptionId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        user,
        plan,
        startDate,
        endDate,
        status,
        stripeSubscriptionId,
        createdAt,
      ];
}