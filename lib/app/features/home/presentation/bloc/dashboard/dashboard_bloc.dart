import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/home/data/repo/index.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/index.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepositoryImpl repository;

  DashboardBloc(this.repository) : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<ChangeChartCategory>(_onChangeChartCategory);
    on<ChangeWeatherDay>(_onChangeWeatherDay);

    add(LoadDashboardData(DashboardFilter.hoy));
  }

  void _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading(event.filter));
    try {
      final data = await repository.getDashboardData(event.filter);
      emit(DashboardLoaded(data, event.filter));
    } catch (_) {}
  }

  void _onChangeChartCategory(
      ChangeChartCategory event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(DashboardLoaded(
        currentState.data,
        currentState.selectedFilter,
        selectedCategory: event.category,
        selectedWeatherDay: currentState.selectedWeatherDay,
      ));
    }
  }

  void _onChangeWeatherDay(
      ChangeWeatherDay event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(DashboardLoaded(
        currentState.data,
        currentState.selectedFilter,
        selectedCategory: currentState.selectedCategory,
        selectedWeatherDay: event.dayIndex,
      ));
    }
  }
}
