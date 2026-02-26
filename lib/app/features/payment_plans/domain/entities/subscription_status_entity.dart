import 'package:equatable/equatable.dart';

class SubscriptionStatusEntity extends Equatable {
  final bool hasActivePlan;
  final String? plan;
  final DateTime? endDate;
  final int daysRemaining;

  const SubscriptionStatusEntity({
    required this.hasActivePlan,
     this.plan,
     this.endDate,
    required this.daysRemaining,
  });
  
  @override
  List<Object?> get props => [
        hasActivePlan,
        plan,
        endDate,
        daysRemaining,
      ];
}
