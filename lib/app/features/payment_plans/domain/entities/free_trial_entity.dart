import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class FreeTrialEntity extends Equatable {
  final int id;
  final RegisterResponse user;
  final PlanEntity plan;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String stripeSubscriptionId;
  final DateTime createdAt;

  const FreeTrialEntity({
    required this.id,
    required this.user,
    required this.plan,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.stripeSubscriptionId,
    required this.createdAt,
  });

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
