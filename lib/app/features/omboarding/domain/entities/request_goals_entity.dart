import 'package:equatable/equatable.dart';

class RequestGoalsEntity extends Equatable {
  final int userId;
  final double monthlySalesTarget;
  final int monthlyClientsTarget;
  final double averageTicketTarget;
  final double averageMarginPerDishTarget;
  final double marginPercentageTarget;

  const RequestGoalsEntity({
    required this.userId,
    required this.monthlySalesTarget,
    required this.monthlyClientsTarget,
    required this.averageTicketTarget,
    required this.averageMarginPerDishTarget,
    required this.marginPercentageTarget,
  });

  @override
  List<Object?> get props => [
        userId,
        monthlySalesTarget,
        monthlyClientsTarget,
        averageTicketTarget,
        averageMarginPerDishTarget,
        marginPercentageTarget,
      ];
}
