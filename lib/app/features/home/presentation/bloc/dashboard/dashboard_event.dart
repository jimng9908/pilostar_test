part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDashboardData extends DashboardEvent {
  final DashboardFilter filter;
  LoadDashboardData(this.filter);

  @override
  List<Object> get props => [filter];
}

class ChangeChartCategory extends DashboardEvent {
  final String category;
  ChangeChartCategory(this.category);

  @override
  List<Object> get props => [category];
}

class ChangeWeatherDay extends DashboardEvent {
  final int dayIndex;
  ChangeWeatherDay(this.dayIndex);

  @override
  List<Object> get props => [dayIndex];
}
