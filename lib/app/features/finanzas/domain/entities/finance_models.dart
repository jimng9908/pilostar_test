import 'package:equatable/equatable.dart';

class FinanceData extends Equatable {
  final String periodSubtitle;
  final EBITDAData ebitda;
  final ComparisonData ingresosVsGastos;
  final List<RatioData> healthRatios;
  final List<CategorizedExpense> qExpenses;
  final double treasuryBalance;
  final List<DebtItem> debts;

  const FinanceData({
    required this.periodSubtitle,
    required this.ebitda,
    required this.ingresosVsGastos,
    required this.healthRatios,
    required this.qExpenses,
    required this.treasuryBalance,
    required this.debts,
  });

  @override
  List<Object?> get props => [
        periodSubtitle,
        ebitda,
        ingresosVsGastos,
        healthRatios,
        qExpenses,
        treasuryBalance,
        debts,
      ];
}

class EBITDAData extends Equatable {
  final double value;
  final double profitabilityPercentage;
  final double growthPercentage;

  const EBITDAData({
    required this.value,
    required this.profitabilityPercentage,
    required this.growthPercentage,
  });

  @override
  List<Object?> get props => [value, profitabilityPercentage, growthPercentage];
}

class ComparisonData extends Equatable {
  final double ingresos;
  final double gastos;
  final double incomeGoal;
  final double expenseGoal;

  const ComparisonData({
    required this.ingresos,
    required this.gastos,
    required this.incomeGoal,
    required this.expenseGoal,
  });

  @override
  List<Object?> get props => [ingresos, gastos];
}

class RatioData extends Equatable {
  final String label;
  final double percentage;
  final String status;
  final double currentAmount;
  final double targetAmount;

  const RatioData({
    required this.label,
    required this.percentage,
    required this.status,
    required this.currentAmount,
    required this.targetAmount,
  });

  @override
  List<Object?> get props =>
      [label, percentage, status, currentAmount, targetAmount];
}

class CategorizedExpense extends Equatable {
  final String label;
  final double amount;
  final double percentage;

  const CategorizedExpense({
    required this.label,
    required this.amount,
    required this.percentage,
  });

  @override
  List<Object?> get props => [label, amount, percentage];
}

class DebtItem extends Equatable {
  final String creditor;
  final double amount;
  final String? icon;

  const DebtItem({
    required this.creditor,
    required this.amount,
    this.icon,
  });

  @override
  List<Object?> get props => [creditor, amount, icon];
}
