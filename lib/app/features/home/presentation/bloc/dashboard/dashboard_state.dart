part of 'dashboard_bloc.dart';

enum DashboardFilter {
  ayer,
  hoy,
  semana,
  mes;

  String get label {
    switch (this) {
      case DashboardFilter.ayer:
        return 'Ayer';
      case DashboardFilter.hoy:
        return 'Hoy';
      case DashboardFilter.semana:
        return 'Esta semana';
      case DashboardFilter.mes:
        return 'Este mes';
    }
  }
}

abstract class DashboardState extends Equatable {
  final DashboardFilter selectedFilter;

  const DashboardState(this.selectedFilter);

  @override
  List<Object> get props => [selectedFilter];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial() : super(DashboardFilter.hoy);
}

class DashboardLoading extends DashboardState {
  const DashboardLoading(super.selectedFilter);
}

class DashboardLoaded extends DashboardState {
  final DashboardEntity data;
  final String selectedCategory;
  final int selectedWeatherDay;

  const DashboardLoaded(
    this.data,
    DashboardFilter filter, {
    this.selectedCategory = 'Facturación',
    this.selectedWeatherDay = 0,
  }) : super(filter);

  @override
  List<Object> get props =>
      [data, selectedCategory, selectedWeatherDay, selectedFilter];
}
