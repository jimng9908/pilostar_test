import 'package:equatable/equatable.dart';

class ProfileSchedule extends Equatable {
  final List<ProfileDailySchedule> days;
  final int totalOpenDays;

  const ProfileSchedule({
    required this.days,
    required this.totalOpenDays,
  });

  @override
  List<Object?> get props => [days, totalOpenDays];

  ProfileSchedule copyWith({
    List<ProfileDailySchedule>? days,
    int? totalOpenDays,
  }) {
    return ProfileSchedule(
      days: days ?? this.days,
      totalOpenDays: totalOpenDays ?? this.totalOpenDays,
    );
  }
}

class ProfileDailySchedule extends Equatable {
  final String dayName;
  final bool isOpen;
  final String openTime;
  final String closeTime;

  const ProfileDailySchedule({
    required this.dayName,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
  });

  @override
  List<Object?> get props => [dayName, isOpen, openTime, closeTime];

  ProfileDailySchedule copyWith({
    String? dayName,
    bool? isOpen,
    String? openTime,
    String? closeTime,
  }) {
    return ProfileDailySchedule(
      dayName: dayName ?? this.dayName,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }
}
