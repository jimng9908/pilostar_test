import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ResponseGoalModel extends ResponseGoalsEntity {
  const ResponseGoalModel({
    required super.id,
    required super.userId,
    required super.monthlySalesTarget,
    required super.monthlyClientsTarget,
    required super.averageTicketTarget,
    required super.averageMarginPerDishTarget,
    required super.marginPercentageTarget,
  });

  factory ResponseGoalModel.fromJson(Map<String, dynamic> json) {
    return ResponseGoalModel(
      id: json['id'],
      userId: json['userId'],
      monthlySalesTarget: json['monthlySalesTarget'],
      monthlyClientsTarget: json['monthlyClientsTarget'].toString(),
      averageTicketTarget: json['averageTicketTarget'],
      averageMarginPerDishTarget: json['averageMarginPerDishTarget'],
      marginPercentageTarget: json['marginPercentageTarget'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'monthlySalesTarget': monthlySalesTarget,
      'monthlyClientsTarget': int.parse(monthlyClientsTarget),
      'averageTicketTarget': averageTicketTarget,
      'averageMarginPerDishTarget': averageMarginPerDishTarget,
      'marginPercentageTarget': marginPercentageTarget,
    };
  }
}