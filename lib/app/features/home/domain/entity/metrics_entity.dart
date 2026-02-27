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

  /// Total Revenue And Expenses :Factory para crear una instancia desde un Map JSON
  factory MetricEntity.fromJsonTotalRevenueAndExpenses(
      Map<String, dynamic> json) {
    if (json['crr_income'] != null &&
        json['prv_income'] != null &&
        json['variation_expenses'] != null) {
      final double crrRevenue = double.parse(json['crr_income']);
      final double prvRevenue = double.parse(json['prv_income']);
      final bool isPositive = crrRevenue > prvRevenue;
      // Calcular el trend porcentual
      final double trendPercentage = double.parse(
          (((crrRevenue - prvRevenue) / prvRevenue) * 100).toStringAsFixed(2));
      return MetricEntity(
        title: "Ingresos",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.totalRevenueAndExpenses,
        goalProgress: double.parse(json['variation_expenses']),
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }

  /// Total Revenue :Factory para crear una instancia desde un Map JSON
  factory MetricEntity.fromJsonTotalRevenue(Map<String, dynamic> json) {
    if (json['crr_revenue'] != null &&
        json['prv_revenue'] != null &&
        json['ratio'] != null) {
      final double crrRevenue = double.parse(json['crr_revenue'].toString());
      final double prvRevenue = double.parse(json['prv_revenue'].toString());
      final bool isPositive = crrRevenue > prvRevenue;
      // Calcular el trend porcentual
      final double trendPercentage = double.parse(
          (((crrRevenue - prvRevenue) / prvRevenue) * 100).toStringAsFixed(2));

      return MetricEntity(
        title: "Facturación Total",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.totalRevenue,
        goalProgress: double.parse(json['ratio']),
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }

  /// Customers :Factory para crear una instancia desde un Map JSON
  factory MetricEntity.fromJsonCustomers(Map<String, dynamic> json) {
    if (json['crr_clients'] != null && json['prv_clients'] != null) {
      final double crrRevenue = double.parse(json['crr_clients'].toString());
      final double prvRevenue = double.parse(json['prv_clients'].toString());
      final bool isPositive = crrRevenue > prvRevenue;
      // Calcular el trend porcentual
      final double trendPercentage = double.parse(
          (((crrRevenue - prvRevenue) / prvRevenue) * 100).toStringAsFixed(2));

      return MetricEntity(
        title: "Reservas",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.bookings,
        // goalProgress: json['ratio'], no se si lo lleva o como se calcula
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }

  /// Average Ticket :Factory para crear una instancia desde un Map JSON
  /// Revisar da error 500
  factory MetricEntity.fromJsonAverageTicket(Map<String, dynamic> json) {
    if (json['crr_revenue'] != null &&
        json['prv_revenue'] != null &&
        json['ratio'] != null) {
      final double crrRevenue = double.parse(json['crr_revenue'].toString());
      final double prvRevenue = double.parse(json['prv_revenue'].toString());
      final bool isPositive = crrRevenue > prvRevenue;
      // Calcular el trend porcentual
      final double trendPercentage = double.parse(
          (((crrRevenue - prvRevenue) / prvRevenue) * 100).toStringAsFixed(2));

      return MetricEntity(
        title: "Ticket Medio",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.averageTicket,
        goalProgress: double.parse(json['ratio']),
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }

  /// Personal Percentage :Factory para crear una instancia desde un Map JSON
  factory MetricEntity.fromJsonPersonalPercentage(Map<String, dynamic> json) {
    if (json['crr_revenue'] != null &&
        json['prv_revenue'] != null &&
        json['variation_ratio_percent'] != null) {
      final double crrRevenue = double.parse(json['crr_revenue'].toString());
      final double prvRevenue = double.parse(json['prv_revenue'].toString());
      final bool isPositive = crrRevenue > prvRevenue;
      // Calcular el trend porcentual
      final double trendPercentage = double.parse(
          (((crrRevenue - prvRevenue) / prvRevenue) * 100).toStringAsFixed(2));

      return MetricEntity(
        title: "% Gasto del Personal",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.personal,
        goalProgress: double.parse(json['variation_ratio_percent']),
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }

  /// Merchandise Percentage :Factory para crear una instancia desde un Map JSON
  factory MetricEntity.fromJsonMerchandisePercentage(
      Map<String, dynamic> json) {
    if (json['crr_pos_revenue'] != null &&
        json['prv_pos_revenue'] != null &&
        json['variation_commodity_pct'] != null) {
      final double crrRevenue =
          double.parse(json['crr_pos_revenue'].toString());
      final double prvRevenue =
          double.parse(json['prv_pos_revenue'].toString());
      final bool isPositive = crrRevenue > prvRevenue;
      // Calcular el trend porcentual
      final double trendPercentage = double.parse(
          (((crrRevenue - prvRevenue) / prvRevenue) * 100).toStringAsFixed(2));

      return MetricEntity(
        title: "% Materia Prima",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.material,
        goalProgress: double.parse(json['variation_commodity_pct']),
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }

  /// Profitability:Factory para crear una instancia desde un Map JSON
  factory MetricEntity.fromJsonProfitability(Map<String, dynamic> json) {
    if (json['crr_income'] != null &&
        json['crr_profitability'] != null &&
        json['variation_profitability'] != null) {
      final double crrRevenue = double.parse(json['crr_income'].toString());
      final double crrProfitability = double.parse(
          json['crr_profitability'].toString()); // no hay prv_income
      final bool isPositive = crrProfitability > 0;
      // Calcular el trend porcentual
      final double trendPercentage = crrProfitability;

      return MetricEntity(
        title: "Productividad",
        value: crrRevenue,
        trend: '$trendPercentage%',
        isPositive: isPositive,
        kpi: KpiType.productivity,
        goalProgress: double.parse(json['variation_profitability']),
      );
    } else {
      return MetricEntity(
        title: '',
        value: 0,
        trend: '',
        isPositive: false,
        kpi: KpiType.totalRevenueAndExpenses,
      );
    }
  }
}
