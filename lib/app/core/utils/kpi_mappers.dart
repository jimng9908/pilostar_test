import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/kpi_type.dart';

class KpiIconMapper {
  static IconData getIcon(KpiType type) {
    switch (type) {
      case KpiType.totalRevenue:
        return Icons.payments_outlined;
      case KpiType.bookings:
      case KpiType.personal:
      case KpiType.material:
      case KpiType.occupancy:
      case KpiType.monthlyClients:
        return Icons.people_alt_outlined;
      case KpiType.googleRating:
        return Icons.star_outline;
      case KpiType.averageTicket:
        return Icons.receipt_outlined;
      case KpiType.ebitda:
        return Icons.star_outline;
      case KpiType.noShows:
        return Icons.people_alt_outlined;
      case KpiType.productivity:
        return Icons.work_outline;
      case KpiType.monthlySales:
        return Icons.attach_money;
      case KpiType.monthlyAverageTicket:
        return Icons.receipt_long;
      case KpiType.totalRevenueAndExpenses:
        return Icons.payments_outlined;
    }
  }
}

class KpiColorMapper {
  static Color getKpiColor(KpiType type) {
    switch (type) {
      case KpiType.totalRevenue:
      case KpiType.monthlySales:
      case KpiType.averageTicket:
      case KpiType.monthlyAverageTicket:
        return const Color(0xFF00C853); // Green
      case KpiType.bookings:
      case KpiType.monthlyClients:
      case KpiType.occupancy:
      case KpiType.personal:
      case KpiType.material:
        return const Color(0xFF7C4DFF); // Purple
      case KpiType.googleRating:
      case KpiType.ebitda:
        return const Color(0xFFFFB300); // Amber
      case KpiType.noShows:
        return const Color(0xFFFF3D00); // Deep Orange
      case KpiType.totalRevenueAndExpenses:
      case KpiType.productivity:
        return const Color(0xFF2979FF); // Blue
    }
  }

  static Color getProgressGoalsColor(double progress) {
    if (progress >= 0.85) {
      return AppColor.ligthGreen; // Verde (Eficiente / Meta alcanzada)
    } else if (progress >= 0.70) {
      return AppColor.yellow; // Amarillo (Precaución / En proceso)
    } else {
      return AppColor.red; // Rojo (Crítico / Alerta)
    }
  }

  static Color getProgressPersonalColor(double progress) {
    if (progress < 0.35) {
      return AppColor.ligthGreen; // Verde (Eficiente / Meta alcanzada)
    } else if (progress < 0.40) {
      return AppColor.yellow; // Amarillo (Precaución / En proceso)
    } else {
      return AppColor.red; // Rojo (Crítico / Alerta)
    }
  }

  static Color getProgressGenericExpenseColor(double progress) {
    if (progress < 0.10) {
      return AppColor.ligthGreen; // Verde (Saludable < 10%)
    } else if (progress < 0.15) {
      return AppColor.yellow; // Amarillo (Aviso 10% - 15%)
    } else {
      return AppColor.red; // Rojo (Alerta > 15%)
    }
  }

  static Color getProgressMateriaColor(double progress) {
    if (progress < 0.30) {
      return AppColor.ligthGreen; // Verde (Eficiente / Meta alcanzada)
    } else if (progress < 0.32) {
      return AppColor.yellow; // Amarillo (Precaución / En proceso)
    } else {
      return AppColor.red; // Rojo (Crítico / Alerta)
    }
  }

  static Color getProgressBarColor(double current, double target,
      {bool isExpense = false}) {
    if (isExpense) {
      if (current > target) {
        return AppColor.red;
      }
      return AppColor.ligthGreen;
    }
    return AppColor.ligthGreen;
  }
}
