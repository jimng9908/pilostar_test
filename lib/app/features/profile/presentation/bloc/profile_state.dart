part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileSchedule schedule;
  final ProfileVenueConfig venueConfig;
  final List<ProfileService> services;
  final List<ProfileGoal> goals;
  final ProfileInfo profileInfo;
  final List<ProfileDataSource> dataSources;
  final DataSourcesSummary? dataSourcesSummary;
  final ProfileGoal? editingGoal;
  final bool isSaving;
  final bool isEditingProfile;
  final bool isLoadingDataSources;
  final bool hasLoadedDataSources;
  final ProfileNotifications notifications;
  final String? cancelReason;
  final String? cancelFeedback;
  final int cancellationStep;
  final int selectedOfferId;
  final bool hasPlanCancelled;
  final bool isRestartingSubscription;

  const ProfileLoaded({
    required this.schedule,
    required this.venueConfig,
    required this.services,
    required this.goals,
    required this.profileInfo,
    this.dataSources = const [],
    this.dataSourcesSummary,
    this.editingGoal,
    this.isSaving = false,
    this.isEditingProfile = false,
    this.isLoadingDataSources = false,
    this.hasLoadedDataSources = false,
    this.notifications = const ProfileNotifications(),
    this.cancelReason,
    this.cancelFeedback,
    this.cancellationStep = 0,
    this.selectedOfferId = 0,
    this.hasPlanCancelled = false,
    this.isRestartingSubscription = false,
  });

  ProfileLoaded copyWith({
    ProfileSchedule? schedule,
    ProfileVenueConfig? venueConfig,
    List<ProfileService>? services,
    List<ProfileGoal>? goals,
    ProfileInfo? profileInfo,
    List<ProfileDataSource>? dataSources,
    DataSourcesSummary? Function()? dataSourcesSummary,
    ProfileGoal? editingGoal,
    bool? isSaving,
    bool? isEditingProfile,
    bool? isLoadingDataSources,
    bool? hasLoadedDataSources,
    ProfileNotifications? notifications,
    String? cancelReason,
    String? cancelFeedback,
    int? cancellationStep,
    int? selectedOfferId,
    bool? hasPlanCancelled,
    bool? isRestartingSubscription,
  }) {
    return ProfileLoaded(
      schedule: schedule ?? this.schedule,
      venueConfig: venueConfig ?? this.venueConfig,
      services: services ?? this.services,
      goals: goals ?? this.goals,
      profileInfo: profileInfo ?? this.profileInfo,
      dataSources: dataSources ?? this.dataSources,
      dataSourcesSummary: dataSourcesSummary != null
          ? dataSourcesSummary()
          : this.dataSourcesSummary,
      editingGoal: editingGoal ?? this.editingGoal,
      isSaving: isSaving ?? this.isSaving,
      isEditingProfile: isEditingProfile ?? this.isEditingProfile,
      isLoadingDataSources: isLoadingDataSources ?? this.isLoadingDataSources,
      hasLoadedDataSources: hasLoadedDataSources ?? this.hasLoadedDataSources,
      notifications: notifications ?? this.notifications,
      cancelReason: cancelReason ?? this.cancelReason,
      cancelFeedback: cancelFeedback ?? this.cancelFeedback,
      cancellationStep: cancellationStep ?? this.cancellationStep,
      selectedOfferId: selectedOfferId ?? this.selectedOfferId,
      hasPlanCancelled: hasPlanCancelled ?? this.hasPlanCancelled,
      isRestartingSubscription:
          isRestartingSubscription ?? this.isRestartingSubscription,
    );
  }

  @override
  List<Object?> get props => [
        schedule,
        venueConfig,
        services,
        goals,
        profileInfo,
        dataSources,
        dataSourcesSummary,
        editingGoal,
        isSaving,
        isEditingProfile,
        isLoadingDataSources,
        notifications,
        cancelReason,
        cancelFeedback,
        cancellationStep,
        selectedOfferId,
        hasPlanCancelled,
        isRestartingSubscription,
      ];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
