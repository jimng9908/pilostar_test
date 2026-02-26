import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/kpi_type.dart';

class MetricEntity extends Equatable {
  final String title;
  final num value;
  final String trend;
  final bool isPositive;
  final double? goalProgress;
  final KpiType kpi; // <--- Changed from iconCode
  final String? subtitle; // p.ej "1,247 reseñas"

  const MetricEntity({
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.kpi,
    this.goalProgress,
    this.subtitle,
  });

  @override
  List<Object?> get props => [title, value, trend, kpi, subtitle, goalProgress];
}
