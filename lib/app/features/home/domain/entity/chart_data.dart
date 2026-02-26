import 'package:equatable/equatable.dart';

class ChartDataEntity extends Equatable {
  final double food;
  final double drinks;
  const ChartDataEntity({required this.food, required this.drinks});
  @override
  List<Object?> get props => [food, drinks];
}