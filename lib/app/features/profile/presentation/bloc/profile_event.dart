part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class LoadDataSources extends ProfileEvent {
  const LoadDataSources();
}

class DisconnectDataSource extends ProfileEvent {
  final String dataSourceId;
  const DisconnectDataSource(this.dataSourceId);

  @override
  List<Object?> get props => [dataSourceId];
}

class ReconnectDataSource extends ProfileEvent {
  final String dataSourceId;
  const ReconnectDataSource(this.dataSourceId);

  @override
  List<Object?> get props => [dataSourceId];
}

class ToggleKpiSelection extends ProfileEvent {
  final String dataSourceId;
  final String kpiId;
  const ToggleKpiSelection({required this.dataSourceId, required this.kpiId});

  @override
  List<Object?> get props => [dataSourceId, kpiId];
}

class UpdateSchedule extends ProfileEvent {
  final ProfileSchedule schedule;
  const UpdateSchedule(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class UpdateVenueConfig extends ProfileEvent {
  final ProfileVenueConfig config;
  const UpdateVenueConfig(this.config);

  @override
  List<Object?> get props => [config];
}

class UpdateServices extends ProfileEvent {
  final List<ProfileService> services;
  const UpdateServices(this.services);

  @override
  List<Object?> get props => [services];
}

class UpdateProfileInfo extends ProfileEvent {
  final ProfileInfo info;
  const UpdateProfileInfo(this.info);

  @override
  List<Object?> get props => [info];
}

class UpdateGoal extends ProfileEvent {
  final ProfileGoal goal;
  const UpdateGoal(
      this.goal); // This might be used for direct updates if any, or we can repurpose

  @override
  List<Object?> get props => [goal];
}

class SaveProfile extends ProfileEvent {
  const SaveProfile();
}

// Goal Form Events
class InitGoalForm extends ProfileEvent {
  final ProfileGoal? goal; // Null for new, Goal for edit
  const InitGoalForm({this.goal});
  @override
  List<Object?> get props => [goal];
}

class UpdateGoalForm extends ProfileEvent {
  final ProfileGoal updatedGoal;
  const UpdateGoalForm(this.updatedGoal);
  @override
  List<Object?> get props => [updatedGoal];
}

class SubmitGoalForm extends ProfileEvent {
  const SubmitGoalForm();
}

class DeleteGoal extends ProfileEvent {
  final String goalId;
  const DeleteGoal(this.goalId);
  @override
  List<Object?> get props => [goalId];
}

class CancelGoalForm extends ProfileEvent {
  const CancelGoalForm();
}

class ToggleEditProfile extends ProfileEvent {
  const ToggleEditProfile();
}

class UpdateNotifications extends ProfileEvent {
  final ProfileNotifications notifications;
  const UpdateNotifications(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class UpdateCancelReason extends ProfileEvent {
  final String reason;
  const UpdateCancelReason(this.reason);

  @override
  List<Object?> get props => [reason];
}

class UpdateCancelFeedback extends ProfileEvent {
  final String feedback;
  const UpdateCancelFeedback(this.feedback);

  @override
  List<Object?> get props => [feedback];
}

class SubmitCancellation extends ProfileEvent {}

class SelectOffer extends ProfileEvent {
  final int offerId;
  const SelectOffer(this.offerId);
}

class NextCancellationStep extends ProfileEvent {}

class PreviousCancellationStep extends ProfileEvent {}

class ResetCancellationFlow extends ProfileEvent {}

class RestartSubscriptionEvent extends ProfileEvent {}
