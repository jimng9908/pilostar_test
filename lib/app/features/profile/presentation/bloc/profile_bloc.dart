import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileBloc(this._profileRepo) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadDataSources>(_onLoadDataSources);
    on<DisconnectDataSource>(_onDisconnectDataSource);
    on<ReconnectDataSource>(_onReconnectDataSource);
    on<ToggleKpiSelection>(_onToggleKpiSelection);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<UpdateVenueConfig>(_onUpdateVenueConfig);
    on<UpdateServices>(_onUpdateServices);
    on<UpdateProfileInfo>(_onUpdateProfileInfo);
    on<UpdateGoal>(_onUpdateGoal);
    on<SaveProfile>(_onSaveProfile);
    on<InitGoalForm>(_onInitGoalForm);
    on<UpdateGoalForm>(_onUpdateGoalForm);
    on<SubmitGoalForm>(_onSubmitGoalForm);
    on<DeleteGoal>(_onDeleteGoal);
    on<CancelGoalForm>(_onCancelGoalForm);
    on<ToggleEditProfile>(_onToggleEditProfile);
    on<UpdateNotifications>(_onUpdateNotifications);
    on<UpdateCancelReason>(_onUpdateCancelReason);
    on<UpdateCancelFeedback>(_onUpdateCancelFeedback);
    on<SubmitCancellation>(_onSubmitCancellation);
    on<NextCancellationStep>(_onNextCancellationStep);
    on<PreviousCancellationStep>(_onPreviousCancellationStep);
    on<ResetCancellationFlow>(_onResetCancellationFlow);
    on<RestartSubscriptionEvent>(_onRestartSubscription);
    on<SelectOffer>(_onSelectOffer);
  }

  void _onToggleEditProfile(
      ToggleEditProfile event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(
          isEditingProfile: !loadedState.isEditingProfile));
    }
  }

  void _onLoadDataSources(
      LoadDataSources event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;

      if (loadedState.dataSources.isNotEmpty) return;

      emit(loadedState.copyWith(isLoadingDataSources: true));

      try {
        final sources = await _profileRepo.getDataSources();
        final summary = await _profileRepo.getSummary();

        emit(loadedState.copyWith(
          dataSources: sources,
          dataSourcesSummary: () => summary,
          isLoadingDataSources: false,
          hasLoadedDataSources: true,
        ));
      } catch (e) {
        emit(loadedState.copyWith(isLoadingDataSources: false));
      }
    }
  }

  void _onDisconnectDataSource(
      DisconnectDataSource event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      final updatedSources = loadedState.dataSources.map((source) {
        if (source.id == event.dataSourceId) {
          return ProfileDataSource(
            id: source.id,
            title: source.title,
            description: source.description,
            status: "Desconectado",
            lastSync: source.lastSync,
            kpis: source.kpis,
            isRequired: source.isRequired,
            hasUnlink: source.hasUnlink,
          );
        }
        return source;
      }).toList();

      emit(loadedState.copyWith(dataSources: updatedSources));
    }
  }

  void _onReconnectDataSource(
      ReconnectDataSource event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      final updatedSources = loadedState.dataSources.map((source) {
        if (source.id == event.dataSourceId) {
          return ProfileDataSource(
            id: source.id,
            title: source.title,
            description: source.description,
            status: "Conectado",
            lastSync: source.lastSync,
            kpis: source.kpis,
            isRequired: source.isRequired,
            hasUnlink: source.hasUnlink,
          );
        }
        return source;
      }).toList();

      emit(loadedState.copyWith(dataSources: updatedSources));
    }
  }

  void _onToggleKpiSelection(
      ToggleKpiSelection event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      final updatedSources = loadedState.dataSources.map((source) {
        if (source.id == event.dataSourceId) {
          final updatedKpis = source.kpisList.map((kpi) {
            if (kpi.id == event.kpiId) {
              return kpi.copyWith(isActive: !kpi.isActive);
            }
            return kpi;
          }).toList();

          final connectedKpis = updatedKpis.where((kpi) => kpi.isActive).length;
          final totalKpis = updatedKpis.length;

          return ProfileDataSource(
            id: source.id,
            title: source.title,
            description: source.description,
            status: source.status,
            lastSync: source.lastSync,
            kpis: "$connectedKpis/$totalKpis",
            isRequired: source.isRequired,
            hasUnlink: source.hasUnlink,
            kpisList: updatedKpis,
          );
        }
        return source;
      }).toList();

      emit(loadedState.copyWith(dataSources: updatedSources));
    }
  }

  void _onUpdateNotifications(
      UpdateNotifications event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded)
          .copyWith(notifications: event.notifications));
    }
  }

  void _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      return;
    }
    emit(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 1000)); // Mock API delay

    // Mock Initial Data
    final initialSchedule = ProfileSchedule(
      totalOpenDays: 6,
      days: [
        const ProfileDailySchedule(
            dayName: 'Lunes',
            isOpen: true,
            openTime: '08:00',
            closeTime: '23:00'),
        const ProfileDailySchedule(
            dayName: 'Martes',
            isOpen: true,
            openTime: '08:00',
            closeTime: '23:00'),
        const ProfileDailySchedule(
            dayName: 'Miércoles',
            isOpen: true,
            openTime: '08:00',
            closeTime: '23:00'),
        const ProfileDailySchedule(
            dayName: 'Jueves',
            isOpen: true,
            openTime: '08:00',
            closeTime: '23:00'),
        const ProfileDailySchedule(
            dayName: 'Viernes',
            isOpen: true,
            openTime: '08:00',
            closeTime: '23:00'),
        const ProfileDailySchedule(
            dayName: 'Sábado',
            isOpen: true,
            openTime: '10:00',
            closeTime: '01:00'),
        const ProfileDailySchedule(
            dayName: 'Domingo', isOpen: false, openTime: '', closeTime: ''),
      ],
    );

    const initialConfig = ProfileVenueConfig(
      totalTables: 9,
      totalCapacity: 36,
      hasTerrace: true,
      interiorTables: 6,
      interiorCapacity: 24,
      terraceTables: 3,
      terraceCapacity: 12,
    );

    const initialServices = [
      ProfileService(
          id: '1',
          title: 'Solo en local',
          description: 'Los clientes consumen en el establecimiento',
          isSelected: true,
          iconAsset: 'assets/icons/store.png'), // Placeholder
      ProfileService(
          id: '2',
          title: 'Para llevar',
          description: 'Los clientes recogen pedidos para consumir fuera',
          isSelected: false,
          iconAsset: 'assets/icons/bag.png'), // Placeholder
      ProfileService(
          id: '3',
          title: 'Delivery',
          description: 'Entregas a domicilio mediante mensajeros o apps',
          isSelected: false,
          iconAsset: 'assets/icons/truck.png'), // Placeholder
    ];

    const initialGoals = [
      ProfileGoal(
        id: '1',
        title: 'Ventas mensuales',
        subtitle: 'Objetivo mensual',
        currentAmount: 16500,
        targetAmount: 81000,
        progress: 0.20,
        lastYearAmount: 12000,
        progressVsLastYear: 80,
        amountVsLastYear: 45000,
        alertThreshold: 95,
        criticalThreshold: 45,
      ),
      ProfileGoal(
        id: '2',
        title: 'Clientes mensuales',
        subtitle: 'Objetivo mensual',
        currentAmount: 1200, // Example count
        targetAmount: 5000,
        progress: 0.24,
        lastYearAmount: 1200,
        progressVsLastYear: 80,
        amountVsLastYear: 3000,
        alertThreshold: 95,
        criticalThreshold: 45,
      ),
      ProfileGoal(
        id: '3',
        title: 'Ticket medio',
        subtitle: 'Objetivo mensual',
        currentAmount: 45.0,
        targetAmount: 55.0,
        progress: 0.81,
        lastYearAmount: 42.0,
        progressVsLastYear: 5,
        amountVsLastYear: 42.0,
        alertThreshold: 95,
        criticalThreshold: 45,
      ),
      ProfileGoal(
        id: '4',
        title: 'Margen promedio por Plato',
        subtitle: 'Objetivo mensual',
        currentAmount: 10.0,
        targetAmount: 15.0,
        progress: 0.66,
        lastYearAmount: 8.0,
        progressVsLastYear: 10,
        amountVsLastYear: 8.0,
        alertThreshold: 95,
        criticalThreshold: 45,
      ),
      ProfileGoal(
        id: '5',
        title: 'Margen',
        subtitle: 'Objetivo mensual',
        currentAmount: 22.0,
        targetAmount: 25.0,
        progress: 0.88,
        lastYearAmount: 20.0,
        progressVsLastYear: 10,
        amountVsLastYear: 20.0,
        alertThreshold: 95,
        criticalThreshold: 45,
      ),
    ];

    const initialInfo = ProfileInfo(
      name: 'Javier García',
      email: 'javier.garcia@cocina.com',
      phone: '+34 612 345 678',
      businessName: 'Cocina Multiplex',
      businessAddress: 'Calle Principal 123, Madrid',
      businessType: 'Restaurante',
      nifCif: 'B12345678',
    );

    emit(ProfileLoaded(
      schedule: initialSchedule,
      venueConfig: initialConfig,
      services: initialServices,
      goals: initialGoals,
      profileInfo: initialInfo,
    ));
  }

  void _onUpdateSchedule(UpdateSchedule event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(schedule: event.schedule));
    }
  }

  void _onUpdateVenueConfig(
      UpdateVenueConfig event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(venueConfig: event.config));
    }
  }

  void _onUpdateServices(UpdateServices event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(services: event.services));
    }
  }

  void _onUpdateProfileInfo(
      UpdateProfileInfo event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(profileInfo: event.info));
    }
  }

  void _onUpdateGoal(UpdateGoal event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      final updatedGoals = loadedState.goals.map((g) {
        return g.id == event.goal.id ? event.goal : g;
      }).toList();
      emit(loadedState.copyWith(goals: updatedGoals));
    }
  }

  void _onSaveProfile(SaveProfile event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(isSaving: true));
      await Future.delayed(
          const Duration(milliseconds: 1500)); // Simulating save
      emit(loadedState.copyWith(isSaving: false, isEditingProfile: false));
      // Optionally emit a "Saved" side effect if using Presentation logic listener
    }
  }

  void _onInitGoalForm(InitGoalForm event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      // If event.goal is null, create a new empty goal
      final goalToEdit = event.goal ??
          const ProfileGoal(
            id: '',
            title: '',
            subtitle: '',
            currentAmount: 0,
            targetAmount: 0,
            progress: 0,
            lastYearAmount: 0,
            progressVsLastYear: 0,
            amountVsLastYear: 0,
            alertThreshold: 85,
            criticalThreshold: 70,
            category: 'Ventas',
            period: 'Semanal',
            unit: '€',
            targetIncrease: 0.10, // Default 10%
          );
      emit(loadedState.copyWith(editingGoal: goalToEdit));
    }
  }

  void _onUpdateGoalForm(UpdateGoalForm event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(editingGoal: event.updatedGoal));
    }
  }

  void _onSubmitGoalForm(SubmitGoalForm event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      final editingGoal = loadedState.editingGoal;
      if (editingGoal != null) {
        final currentGoals = List<ProfileGoal>.from(loadedState.goals);

        if (editingGoal.id.isEmpty) {
          // Create new goal
          final newGoal = editingGoal.copyWith(
              id: DateTime.now().millisecondsSinceEpoch.toString());
          currentGoals.add(newGoal);
        } else {
          // Update existing goal
          final index = currentGoals.indexWhere((g) => g.id == editingGoal.id);
          if (index != -1) {
            currentGoals[index] = editingGoal;
          }
        }

        emit(loadedState.copyWith(
          goals: currentGoals,
          editingGoal: null, // Clear form
        ));
      }
    }
  }

  void _onDeleteGoal(DeleteGoal event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      final updatedGoals =
          loadedState.goals.where((g) => g.id != event.goalId).toList();
      emit(loadedState.copyWith(goals: updatedGoals));
    }
  }

  void _onCancelGoalForm(CancelGoalForm event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(editingGoal: null));
    }
  }

  void _onUpdateCancelReason(
      UpdateCancelReason event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(cancelReason: event.reason));
    }
  }

  void _onUpdateCancelFeedback(
      UpdateCancelFeedback event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(cancelFeedback: event.feedback));
    }
  }

  void _onSubmitCancellation(
      SubmitCancellation event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;

      emit(loadedState.copyWith(
          isSaving: true)); // Reutilizamos tu flag de carga

      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulación

        emit(loadedState.copyWith(
            isSaving: false, cancellationStep: 3, hasPlanCancelled: true));
        // Aquí podrías disparar una navegación o cerrar la modal
      } catch (e) {
        emit(loadedState.copyWith(isSaving: false));
      }
    }
  }

  void _onNextCancellationStep(
      NextCancellationStep event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(
          cancellationStep: loadedState.cancellationStep + 1));
    }
  }

  void _onPreviousCancellationStep(
      PreviousCancellationStep event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      if (loadedState.cancellationStep > 0) {
        emit(loadedState.copyWith(
            cancellationStep: loadedState.cancellationStep - 1));
      }
    }
  }

  void _onResetCancellationFlow(
      ResetCancellationFlow event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(
        cancellationStep: 0,
        cancelReason: null,
        cancelFeedback: null,
      ));
    }
  }

  FutureOr<void> _onSelectOffer(SelectOffer event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(selectedOfferId: event.offerId));
    }
  }

  FutureOr<void> _onRestartSubscription(
      RestartSubscriptionEvent event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      emit(loadedState.copyWith(isRestartingSubscription: true));
      await Future.delayed(const Duration(seconds: 2));
      emit(loadedState.copyWith(
        isRestartingSubscription: false,
        hasPlanCancelled: false,
        cancellationStep: 0,
        cancelReason: null,
        cancelFeedback: null,
      ));
    }
  }
}
