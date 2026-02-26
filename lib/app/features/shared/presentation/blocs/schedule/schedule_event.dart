part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {}

class UpdateTimeEvent extends ScheduleEvent {
  final String day, type, time;
  UpdateTimeEvent(this.day, this.type, this.time);

  @override
  List<Object?> get props => [day, type, time];
}

class SaveSchedulesEvent extends ScheduleEvent {
  @override
  List<Object?> get props => [];
}

class ToggleEditModeEvent extends ScheduleEvent {
  final bool isEditing;
  ToggleEditModeEvent(this.isEditing);

  @override
  List<Object?> get props => [isEditing];
}

class ToggleSameScheduleEvent extends ScheduleEvent {
  final bool isSame;
  ToggleSameScheduleEvent(this.isSame);

  @override
  List<Object?> get props => [isSame];
}

class SelectDayEvent extends ScheduleEvent {
  final String day;
  SelectDayEvent(this.day);

  @override
  List<Object?> get props => [day];
}

class RemoveDayEvent extends ScheduleEvent {
  final String day;
  RemoveDayEvent(this.day);

  @override
  List<Object?> get props => [day];
}

class DeleteGroupEvent extends ScheduleEvent {
  final int index;
  DeleteGroupEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class EditGroupEvent extends ScheduleEvent {
  final int index;
  EditGroupEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class InitializeScheduleEvent extends ScheduleEvent {
  final List<ProfileDailySchedule> days;
  InitializeScheduleEvent(this.days);

  @override
  List<Object?> get props => [days];
}
