import 'package:equatable/equatable.dart';

class ProfileGoal extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final double currentAmount;
  final double targetAmount;
  final double progress;
  final double lastYearAmount;
  final double progressVsLastYear; // e.g. 80.0
  final double amountVsLastYear; // e.g. 45000
  final int alertThreshold;
  final int criticalThreshold;

  final String category; // e.g., 'Ventas'
  final String period; // e.g., 'Mensual'
  final String unit; // e.g., '€ Euros'
  final double targetIncrease; // e.g., 0.10 for +10%

  const ProfileGoal({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.currentAmount,
    required this.targetAmount,
    required this.progress,
    required this.lastYearAmount,
    required this.progressVsLastYear,
    required this.amountVsLastYear,
    required this.alertThreshold,
    required this.criticalThreshold,
    this.category = 'Ventas',
    this.period = 'Mensual',
    this.unit = '€ Euros',
    this.targetIncrease = 0.0,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        currentAmount,
        targetAmount,
        progress,
        lastYearAmount,
        progressVsLastYear,
        amountVsLastYear,
        alertThreshold,
        criticalThreshold,
        category,
        period,
        unit,
        targetIncrease,
      ];

  ProfileGoal copyWith({
    String? id,
    String? title,
    String? subtitle,
    double? currentAmount,
    double? targetAmount,
    double? progress,
    double? lastYearAmount,
    double? progressVsLastYear,
    double? amountVsLastYear,
    int? alertThreshold,
    int? criticalThreshold,
    String? category,
    String? period,
    String? unit,
    double? targetIncrease,
  }) {
    return ProfileGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      currentAmount: currentAmount ?? this.currentAmount,
      targetAmount: targetAmount ?? this.targetAmount,
      progress: progress ?? this.progress,
      lastYearAmount: lastYearAmount ?? this.lastYearAmount,
      progressVsLastYear: progressVsLastYear ?? this.progressVsLastYear,
      amountVsLastYear: amountVsLastYear ?? this.amountVsLastYear,
      alertThreshold: alertThreshold ?? this.alertThreshold,
      criticalThreshold: criticalThreshold ?? this.criticalThreshold,
      category: category ?? this.category,
      period: period ?? this.period,
      unit: unit ?? this.unit,
      targetIncrease: targetIncrease ?? this.targetIncrease,
    );
  }
}
