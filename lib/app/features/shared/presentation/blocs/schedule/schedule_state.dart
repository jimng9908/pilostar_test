part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  final bool isEditing;
  final bool isSameScheduleEveryDay;
  final String selectedDay;
  final Map<String, Map<String, String>> inputData;
  final List<Map<String, String>> savedGroups;

  final bool isInitialized;

  const ScheduleState({
    this.isEditing = true,
    this.isSameScheduleEveryDay = false,
    this.selectedDay = "Lunes",
    this.inputData = const {},
    this.savedGroups = const [],
    this.isInitialized = false,
  });

  ScheduleState copyWith({
    bool? isEditing,
    bool? isSameScheduleEveryDay,
    String? selectedDay,
    Map<String, Map<String, String>>? inputData,
    List<Map<String, String>>? savedGroups,
    bool? isInitialized,
  }) {
    return ScheduleState(
      isEditing: isEditing ?? this.isEditing,
      isSameScheduleEveryDay:
          isSameScheduleEveryDay ?? this.isSameScheduleEveryDay,
      selectedDay: selectedDay ?? this.selectedDay,
      inputData: inputData ?? this.inputData,
      savedGroups: savedGroups ?? this.savedGroups,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props =>
      [isEditing, isSameScheduleEveryDay, selectedDay, inputData, savedGroups];
}
