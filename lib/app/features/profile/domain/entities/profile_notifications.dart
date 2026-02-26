import 'package:equatable/equatable.dart';

class ProfileNotifications extends Equatable {
  final bool pushEnabled;
  final bool criticalAlertsEnabled;
  final bool performanceAlertsEnabled;
  final double windThreshold;
  final String weatherSummaryTime;

  const ProfileNotifications({
    this.pushEnabled = true,
    this.criticalAlertsEnabled = true,
    this.performanceAlertsEnabled = true,
    this.windThreshold = 30.0,
    this.weatherSummaryTime = '18:00',
  });

  ProfileNotifications copyWith({
    bool? pushEnabled,
    bool? criticalAlertsEnabled,
    bool? performanceAlertsEnabled,
    double? windThreshold,
    String? weatherSummaryTime,
  }) {
    return ProfileNotifications(
      pushEnabled: pushEnabled ?? this.pushEnabled,
      criticalAlertsEnabled:
          criticalAlertsEnabled ?? this.criticalAlertsEnabled,
      performanceAlertsEnabled:
          performanceAlertsEnabled ?? this.performanceAlertsEnabled,
      windThreshold: windThreshold ?? this.windThreshold,
      weatherSummaryTime: weatherSummaryTime ?? this.weatherSummaryTime,
    );
  }

  @override
  List<Object?> get props => [
        pushEnabled,
        criticalAlertsEnabled,
        performanceAlertsEnabled,
        windThreshold,
        weatherSummaryTime,
      ];
}
