import 'package:equatable/equatable.dart';

class PlanEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final String currency;
  final int durationInDays;
  final String stripePriceId;

  const PlanEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.durationInDays,
    required this.stripePriceId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        currency,
        durationInDays,
        stripePriceId,
      ];
}
