import 'package:rockstardata_apk/app/features/payment_plans/domain/entities/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.currency,
    required super.durationInDays,
    required super.stripePriceId,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      currency: json['currency'],
      durationInDays: json['durationInDays'],
      stripePriceId: json['stripePriceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'durationInDays': durationInDays,
      'stripePriceId': stripePriceId,
    };
  }
}
