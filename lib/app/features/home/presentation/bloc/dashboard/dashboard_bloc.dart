import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/index.dart';
import 'package:rockstardata_apk/app/features/home/domain/repo/index.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final HomeRepo repository;

  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<ChangeChartCategory>(_onChangeChartCategory);
    on<ChangeWeatherDay>(_onChangeWeatherDay);

    add(LoadDashboardData(DashboardFilter.hoy));
  }

  void _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading(event.filter));
    try {
      // final data = await repository.getDashboardData(event.filter);
      final data = await getDashBoarEntity(event.filter);
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

  Future<DashboardEntity> getDashBoarEntity(DashboardFilter filter) async {
    List<MetricEntity> metrics = [];
    //Obtener metricas por separado
    print("!!!!!revision!!!!!");
    final totalRevenueAndExpenses =
        await repository.getTotalRevenueAndExpenses(filter);
    totalRevenueAndExpenses != null
        ? metrics.add(totalRevenueAndExpenses)
        : null;
    final totalRevenue = await repository.getTotalRevenue(filter);
    totalRevenue != null ? metrics.add(totalRevenue) : null;
    final customers = await repository.getCustomers(filter);
    customers != null ? metrics.add(customers) : null;
    final averageTicket = await repository.getAverageTicket(filter);
    averageTicket != null ? metrics.add(averageTicket) : null;
    final pPercentage = await repository.getPersonalPercentage(filter);
    pPercentage != null ? metrics.add(pPercentage) : null;
    final mPercentage = await repository.getMerchandisePercentage(filter);
    mPercentage != null ? metrics.add(mPercentage) : null;
    final profitability = await repository.getProfitability(filter);
    profitability != null ? metrics.add(profitability) : null;

    return DashboardEntity(
      filterType: filter.label,
      mainAmount: 2450,
      mainGoal: 21000,
      mainPercentage: -5.2,
      chartData: const ChartDataEntity(food: 1950, drinks: 500),
      metrics: metrics,
      objectives: const [
        ObjectiveEntity(
            title: "Ventas mensuales",
            current: 86420,
            target: 90000,
            unit: "€",
            kpi: KpiType.monthlySales),
        ObjectiveEntity(
            title: "Clientes mensuales",
            current: 1200,
            target: 1500,
            unit: "clientes",
            kpi: KpiType.monthlyClients),
        ObjectiveEntity(
            title: "Ticket medio",
            current: 47.50,
            target: 50,
            unit: "€",
            kpi: KpiType.monthlyAverageTicket),
      ],
    );
  }
}
