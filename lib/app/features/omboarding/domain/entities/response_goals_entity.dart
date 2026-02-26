import 'package:equatable/equatable.dart';

class ResponseGoalsEntity extends Equatable {
  final int id;
  final int userId;
  final String monthlySalesTarget;
  final String monthlyClientsTarget;
  final String averageTicketTarget;
  final String averageMarginPerDishTarget;
  final String marginPercentageTarget;

  const ResponseGoalsEntity({
    required this.id,
    required this.userId,
    required this.monthlySalesTarget,
    required this.monthlyClientsTarget,
    required this.averageTicketTarget,
    required this.averageMarginPerDishTarget,
    required this.marginPercentageTarget,
  });

  const ResponseGoalsEntity.empty()
      : this(
          id: 0,
          userId: 0,
          monthlySalesTarget: '',
          monthlyClientsTarget: '',
          averageTicketTarget: '',
          averageMarginPerDishTarget: '',
          marginPercentageTarget: '',
        );

  @override
  List<Object?> get props => [
        id,
        userId,
        monthlySalesTarget,
        monthlyClientsTarget,
        averageTicketTarget,
        averageMarginPerDishTarget,
        marginPercentageTarget,
      ];
}
