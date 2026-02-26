import 'package:rockstardata_apk/app/features/home/index.dart';

class DashboardRepositoryImpl {
  Future<DashboardEntity> getDashboardData(DashboardFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulación API

    if (filter == DashboardFilter.ayer) {
      return DashboardEntity(
        filterType: filter.label,
        mainAmount: 2450,
        mainGoal: 21000,
        mainPercentage: -5.2,
        chartData: const ChartDataEntity(food: 1950, drinks: 500),
        metrics: const [
          MetricEntity(
            title: "Facturación Total",
            value: 2450,
            trend: "-5.2%",
            isPositive: false,
            kpi: KpiType.totalRevenue,
            goalProgress: 0.65,
          ),
          MetricEntity(
            title: "Reservas",
            value: 35,
            trend: "-2.0%",
            isPositive: false,
            kpi: KpiType.bookings,
          ),
          MetricEntity(
            title: "Google Rating",
            value: 4.7,
            trend: "0",
            isPositive: true,
            kpi: KpiType.googleRating,
            subtitle: "1,245 reseñas",
            goalProgress: 0.77,
          ),
          MetricEntity(
            title: "Ocupación",
            value: 65,
            trend: "-5%",
            isPositive: false,
            kpi: KpiType.occupancy,
            goalProgress: 0.85,
          ),
          MetricEntity(
            title: "Ticket Medio",
            value: 42.10,
            trend: "-1.5%",
            isPositive: false,
            kpi: KpiType.averageTicket,
            goalProgress: 0.70,
          ),
          MetricEntity(
            title: "% Mataria Prima",
            value: 29,
            trend: "+4%",
            isPositive: true,
            kpi: KpiType.material,
            goalProgress: 0.97,
          ),
          MetricEntity(
            title: "% Gasto de Personal",
            value: 31,
            trend: "+4%",
            isPositive: true,
            kpi: KpiType.personal,
            goalProgress: 0.96,
          ),
          MetricEntity(
            title: "No Shows",
            value: 4,
            trend: "+0.4%",
            isPositive: true,
            kpi: KpiType.noShows,
          ),
          MetricEntity(
            title: "Productividad",
            value: 320,
            trend: "+0.4%",
            isPositive: true,
            kpi: KpiType.productivity,
            goalProgress: 0.75,
          ),
        ],
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

    if (filter == DashboardFilter.hoy) {
      return DashboardEntity(
        filterType: filter.label,
        mainAmount: 2847,
        mainGoal: 21000,
        mainPercentage: 12.5,
        chartData: const ChartDataEntity(food: 2270, drinks: 1577),
        metrics: const [
          MetricEntity(
            title: "Facturación Total",
            value: 2847,
            trend: "+12.5%",
            isPositive: true,
            kpi: KpiType.totalRevenue,
            goalProgress: 0.82,
          ),
          MetricEntity(
            title: "Reservas",
            value: 48,
            trend: "+0.6%",
            isPositive: true,
            kpi: KpiType.bookings,
          ),
          MetricEntity(
            title: "Google Rating",
            value: 4.7,
            trend: "0",
            isPositive: true,
            kpi: KpiType.googleRating,
            subtitle: "1,247 reseñas",
            goalProgress: 0.77,
          ),
          MetricEntity(
            title: "Ocupación",
            value: 76,
            trend: "+8%",
            isPositive: true,
            kpi: KpiType.occupancy,
            goalProgress: 0.96,
          ),
          MetricEntity(
            title: "Ticket Medio",
            value: 45.30,
            trend: "+2.8%",
            isPositive: true,
            kpi: KpiType.averageTicket,
            goalProgress: 0.77,
          ),
          MetricEntity(
            title: "% Mataria Prima",
            value: 29,
            trend: "+4%",
            isPositive: true,
            kpi: KpiType.material,
            goalProgress: 0.97,
          ),
          MetricEntity(
            title: "% Gasto de Personal",
            value: 31,
            trend: "+4%",
            isPositive: true,
            kpi: KpiType.personal,
            goalProgress: 0.96,
          ),
          MetricEntity(
            title: "No Shows",
            value: 4,
            trend: "+0.4%",
            isPositive: true,
            kpi: KpiType.noShows,
          ),
          MetricEntity(
            title: "Productividad",
            value: 320,
            trend: "+0.4%",
            isPositive: true,
            kpi: KpiType.productivity,
            goalProgress: 0.2,
          ),
        ],
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

    if (filter == DashboardFilter.semana) {
      return DashboardEntity(
        filterType: filter.label,
        mainAmount: 19847,
        mainGoal: 21000,
        mainPercentage: 13.2,
        chartData: const ChartDataEntity(food: 12270, drinks: 7577),
        metrics: const [
          MetricEntity(
            title: "Reservas",
            value: 187,
            trend: "+4",
            isPositive: true,
            kpi: KpiType.bookings,
          ),
          MetricEntity(
              title: "Google Rating",
              value: 4.7,
              trend: "+0.2",
              isPositive: true,
              kpi: KpiType.googleRating,
              goalProgress: 0.77),
          MetricEntity(
              title: "Ocupación",
              value: 76,
              trend: "+8%",
              isPositive: true,
              kpi: KpiType.occupancy,
              goalProgress: 0.77),
          MetricEntity(
              title: "Ticket Medio",
              value: 45.30,
              trend: "+2.8%",
              isPositive: true,
              kpi: KpiType.averageTicket,
              goalProgress: 0.77),
        ],
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

    // Default: Mes
    return DashboardEntity(
      filterType: filter.label,
      mainAmount: 86420,
      mainGoal: 21000,
      mainPercentage: 9.1,
      chartData: const ChartDataEntity(food: 56000, drinks: 30420),
      metrics: const [
        MetricEntity(
          title: "Reservas",
          value: 840,
          trend: "+5.6%",
          isPositive: true,
          kpi: KpiType.bookings,
        ),
        MetricEntity(
          title: "Google Rating",
          value: 4.7,
          trend: "0",
          isPositive: true,
          kpi: KpiType.googleRating,
          subtitle: "1,247 reseñas",
          goalProgress: 0.90,
        ),
        MetricEntity(
          title: "Ocupación",
          value: 78,
          trend: "+4%",
          isPositive: true,
          kpi: KpiType.occupancy,
          goalProgress: 0.88,
        ),
        MetricEntity(
          title: "Ticket Medio",
          value: 47.50,
          trend: "+3.2%",
          isPositive: true,
          kpi: KpiType.averageTicket,
          goalProgress: 0.95,
        ),
      ],
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
