// domain/entities/dashboard_entity.dart
import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/index.dart';

class DashboardEntity extends Equatable {
  final String filterType; // 'Hoy', 'Esta semana', 'Este mes'
  final double mainAmount;
  final double mainGoal;
  final double mainPercentage;
  final List<MetricEntity> metrics;
  final List<ObjectiveEntity> objectives;
  final ChartDataEntity? chartData; // Solo para 'Hoy' y 'Este mes'

  const DashboardEntity({
    required this.filterType,
    required this.mainAmount,
    required this.mainGoal,
    required this.mainPercentage,
    required this.metrics,
    required this.objectives,
    this.chartData,
  });

  @override
  List<Object?> get props => [filterType, mainAmount, metrics, objectives, chartData];
}



