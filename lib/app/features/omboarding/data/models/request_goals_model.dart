import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class RequestGoalsModel extends RequestGoalsEntity {
  const RequestGoalsModel({
    required super.userId,
    required super.monthlySalesTarget,
    required super.monthlyClientsTarget,
    required super.averageTicketTarget,
    required super.averageMarginPerDishTarget,
    required super.marginPercentageTarget,
  });

  factory RequestGoalsModel.fromEntity(RequestGoalsEntity entity) {
    return RequestGoalsModel(
      userId: entity.userId,
      monthlySalesTarget: entity.monthlySalesTarget,
      monthlyClientsTarget: entity.monthlyClientsTarget,
      averageTicketTarget: entity.averageTicketTarget,
      averageMarginPerDishTarget: entity.averageMarginPerDishTarget,
      marginPercentageTarget: entity.marginPercentageTarget,
    );
  }

  RequestGoalsEntity toEntity() {
    return RequestGoalsEntity(
      userId: userId,
      monthlySalesTarget: monthlySalesTarget,
      monthlyClientsTarget: monthlyClientsTarget,
      averageTicketTarget: averageTicketTarget,
      averageMarginPerDishTarget: averageMarginPerDishTarget,
      marginPercentageTarget: marginPercentageTarget,
    );
  }

  factory RequestGoalsModel.fromJson(Map<String, dynamic> json) {
    return RequestGoalsModel(
      userId: json['userId'],
      monthlySalesTarget: json['monthlySalesTarget'],
      monthlyClientsTarget: json['monthlyClientsTarget'],
      averageTicketTarget: json['averageTicketTarget'],
      averageMarginPerDishTarget: json['averageMarginPerDishTarget'],
      marginPercentageTarget: json['marginPercentageTarget'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'monthlySalesTarget': monthlySalesTarget,
      'monthlyClientsTarget': monthlyClientsTarget,
      'averageTicketTarget': averageTicketTarget,
      'averageMarginPerDishTarget': averageMarginPerDishTarget,
      'marginPercentageTarget': marginPercentageTarget,
    };
  }
}