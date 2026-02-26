import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/kpi_type.dart';

class ObjectiveEntity extends Equatable {
  final String title;
  final num current;
  final num target;
  final String unit;
  final KpiType kpi;

  const ObjectiveEntity(
      {required this.title,
      required this.current,
      required this.target,
      required this.unit,
      required this.kpi});

  @override
  List<Object?> get props => [title, current, target, unit, kpi];
}
