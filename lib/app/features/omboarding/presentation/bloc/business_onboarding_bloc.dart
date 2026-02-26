import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

part 'business_onboarding_event.dart';
part 'business_onboarding_state.dart';

class BusinessOnboardingBloc
    extends Bloc<BusinessOnboardingEvent, BusinessOnboardingState> {
  final GetBusinessInformation getBusinessInformation;
  final GetLocalUserUsecase getLocalUserUsecase;
  final CreateOrganization createOrganizationUsecase;
  final CreateCompany createCompanyUsecase;
  final CreateVenue createVenueUsecase;
  final ConnectDataSources connectDataSourcesUsecase;
  final StartAutoConfig startAutoConfigUsecase;
  final GetKpiListByUser getKpiListByUser;
  final SubmitKpiPreferences submitKpiPreferences;
  final SubmitGoals submitGoals;

  BusinessOnboardingBloc(
      {required this.getBusinessInformation,
      required this.getLocalUserUsecase,
      required this.createOrganizationUsecase,
      required this.createCompanyUsecase,
      required this.createVenueUsecase,
      required this.connectDataSourcesUsecase,
      required this.startAutoConfigUsecase,
      required this.getKpiListByUser,
      required this.submitKpiPreferences,
      required this.submitGoals})
      : super(BusinessOnboardingInitial()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<GoToManualEntry>(_onGoToManualEntry);
    on<ImportGoogleData>(_onImportGoogleData);
    on<ConfirmGoogleData>(_onConfirmGoogleData);
    on<SubmitManualData>(_onSubmitManualData);
    on<BuisinessTypeSelected>(_onBuisinessTypeSelected);
    on<SubmitBusinessType>(_onSubmitBusinessType);
    on<SaveTimeSchedulesEvent>(_onSaveTimeSchedules);
    on<ConnectSources>(_onConnectSources);
    on<DisconnectSources>(_onDisconnectSources);
    on<ConfirmSources>(_onConfirmSources);
    on<SubmitServices>(_onSubmitServices);
    on<ToggleService>(_onToggleService);
    on<ToggleTerrace>(_onToggleTerrace);
    on<UpdateLocalConfig>(_onUpdateLocalConfig);
    on<ConfirmLocalConfig>(_onConfirmLocalConfig);
    on<StartConfiguration>(_onStartConfiguration);
    on<StartAutomaticConfiguration>(_onStartAutomaticConfiguration);
    on<ConfirmKpiSelection>(_onConfirmKpisSelection);
    on<GoToConfigObjetivesGoals>(_onGoToConfigObjetivesGoals);
    on<SubmitObjectives>(_onSubmitObjectives);
    on<GoToKpiSelection>(_onGoToKpiSelection);
    on<ToggleKpi>(_onToggleKpi);
    on<ChangeKpiFilter>(_onChangeKpiFilter);
    on<BackToPrevious>(_onBackToPrevious);
  }

  // Helper para obtener el estado actual cargado con datos
  BusinessOnboardingLoaded get _currentData {
    if (state is BusinessOnboardingLoaded) {
      return state as BusinessOnboardingLoaded;
    }
    return const BusinessOnboardingLoaded();
  }

  void _onStartOnboarding(
      StartOnboarding event, Emitter<BusinessOnboardingState> emit) {
    emit(BusinessOnboardingLoaded(
      method: event.method,
      step: event.method == OnboardingMethod.automatic
          ? OnboardingStep.googleIntro
          : OnboardingStep.manualEntry,
    ));
  }

  void _onGoToManualEntry(
      GoToManualEntry event, Emitter<BusinessOnboardingState> emit) {
    emit(_currentData.copyWith(
        method: OnboardingMethod.manual, step: OnboardingStep.manualEntry));
  }

  Future<void> _onImportGoogleData(
      ImportGoogleData event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;

    emit(const BusinessOnboardingLoading(progress: 0.1));

    final userResult = await getLocalUserUsecase();
    final user = userResult.fold((l) => null, (r) => r);

    if (user == null) {
      final failure = userResult.fold((l) => l, (r) => null);
      emit(dataBefore.copyWith(
        fetchingData: false,
        hasError: true,
        errorMessage: failure?.errorMessage,
        endingStepIndex: 0,
      ));
      return;
    }

    emit(const BusinessOnboardingLoading(progress: 0.4));

    final result =
        await getBusinessInformation(event.placeUrl, user.accessToken);

    emit(const BusinessOnboardingLoading(progress: 0.7));

    await result.fold(
      (failure) async {
        emit(
          dataBefore.copyWith(
            fetchingData: false,
            hasError: true,
            errorMessage: failure.errorMessage,
            endingStepIndex: 0,
          ),
        );
      },
      (info) async {
        emit(const BusinessOnboardingLoading(progress: 1.0));
        await Future.delayed(const Duration(milliseconds: 500));
        emit(dataBefore.copyWith(
          step: OnboardingStep.googleReview,
          businessInformations: info,
          fetchingData: false,
          hasError: false,
          errorMessage: null,
          endingStepIndex: 0,
        ));
      },
    );
  }

  Future<void> _onConfirmGoogleData(
      ConfirmGoogleData event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      step: OnboardingStep.googleDataConfirmed,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onSubmitManualData(
      SubmitManualData event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      step: OnboardingStep.manualDataConfirmed, // O el siguiente paso lógico
      name: event.name,
      address: event.address,
      phone: event.phone,
      email: event.email,
      website: event.website,
      zoneCode: event.zoneCode,
      municipalityCode: event.municipalityCode,
      selectedMunicipality: event.selectedMunicipality,
      cif: event.cif,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onConnectSources(
      ConnectSources event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    final connected = List<DataSource>.from(dataBefore.connectedSources);
    if (!connected.any((s) => s.id == event.sourceId)) {
      connected.add(DataSource(
        id: event.sourceId,
        name: event.sourceName ?? '',
        key: event.apiKey ?? '',
        email: event.email ?? '',
        password: event.password ?? '',
      ));
    }

    emit(dataBefore.copyWith(
      connectedSources: connected,
      lastAppLocationId:
          event.lastAppLocationId ?? dataBefore.lastAppLocationId,
      lastAppLocationName:
          event.lastAppLocationName ?? dataBefore.lastAppLocationName,
      lastAppCallbackUrl:
          event.lastAppCallbackUrl ?? dataBefore.lastAppCallbackUrl,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onDisconnectSources(
      DisconnectSources event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;

    final connected = List<DataSource>.from(dataBefore.connectedSources);
    if (connected.any((s) => s.id == event.sourceId)) {
      connected.removeWhere((s) => s.id == event.sourceId);
    }

    emit(dataBefore.copyWith(
      connectedSources: connected,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onConfirmSources(
      ConfirmSources event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      step: OnboardingStep.sourcesConfirmed,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onBuisinessTypeSelected(BuisinessTypeSelected event,
      Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      businessType: event.businessType,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onSubmitBusinessType(
      SubmitBusinessType event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      step: OnboardingStep.businessTypeConfirmed,
      businessType: event.businessType,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onToggleService(
      ToggleService event, Emitter<BusinessOnboardingState> emit) async {
    final data = _currentData;
    final services = List<String>.from(data.selectedServices);

    if (services.contains(event.service)) {
      services.remove(event.service);
    } else {
      services.add(event.service);
    }

    emit(data.copyWith(
      selectedServices: services,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onSaveTimeSchedules(SaveTimeSchedulesEvent event,
      Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      step: OnboardingStep.timeSchedulesConfirmed,
      savedGroups: event.savedGroups,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onSubmitServices(
      SubmitServices event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
      step: OnboardingStep.servicesConfirmed,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  void _onToggleTerrace(
      ToggleTerrace event, Emitter<BusinessOnboardingState> emit) {
    emit(_currentData.copyWith(
      hasTerrace: event.hasTerrace,
      exteriorTables:
          event.hasTerrace == false ? 0 : _currentData.exteriorTables,
      exteriorCapacity:
          event.hasTerrace == false ? 0 : _currentData.exteriorCapacity,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  void _onUpdateLocalConfig(
      UpdateLocalConfig event, Emitter<BusinessOnboardingState> emit) {
    emit(_currentData.copyWith(
      interiorTables: event.interiorTables,
      interiorCapacity: event.interiorCapacity,
      exteriorTables: event.exteriorTables,
      exteriorCapacity: event.exteriorCapacity,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  void _onConfirmLocalConfig(
      ConfirmLocalConfig event, Emitter<BusinessOnboardingState> emit) {
    emit(_currentData.copyWith(
      step: OnboardingStep.localConfigConfirmed,
      hasError: false,
      errorMessage: null,
      endingStepIndex: 0,
    ));
  }

  Future<void> _onStartConfiguration(
      StartConfiguration event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
        hasError: false, errorMessage: null, endingStepIndex: 0));

    try {
      // 1. Obtener Usuario Local
      final userResult = await getLocalUserUsecase();
      final user = userResult.fold((l) => null, (r) => r);

      if (user == null) {
        emit(_currentData.copyWith(
            hasError: true, errorMessage: "User not found"));
        return;
      }

      // --- PASO A: Crear Organización (endingStepIndex: 1) ---
      final organizationResult = await createOrganizationUsecase(
          _currentData.name, _currentData.cif, user.accessToken);

      final organization = await organizationResult.fold(
        (f) {
          emit(_currentData.copyWith(
              hasError: true, errorMessage: f.errorMessage));
          return null;
        },
        (r) {
          emit(_currentData.copyWith(endingStepIndex: 1));
          return r;
        },
      );
      if (organization == null) return;

      // --- PASO B: Crear Compañía (endingStepIndex: 2) ---
      final companyResult = await createCompanyUsecase(
          RequestCompany(
              name: _currentData.name,
              address: _currentData.address,
              phone: _currentData.phone!,
              email: _currentData.email,
              website: _currentData.website,
              organizationId: organization.id!),
          user.accessToken);

      final company = await companyResult.fold(
        (f) {
          emit(_currentData.copyWith(
              hasError: true, errorMessage: f.errorMessage));
          return null;
        },
        (r) {
          emit(_currentData.copyWith(endingStepIndex: 2));
          return r;
        },
      );
      if (company == null) return;

      // --- PASO C: Crear Venue (endingStepIndex: 3) ---
      final servicesHoursJson = jsonEncode(_currentData.savedGroups);
      final venueResult = await createVenueUsecase(
        RequestVenue(
          name: _currentData.name,
          companyId: company.id,
          organizationId: company.organizationId,
          type: _getVenueType([_currentData.businessType]),
          isActive: true,
          local: _currentData.selectedServices.contains('Local'),
          delivery: _currentData.selectedServices.contains('Delivery'),
          takeaway: _currentData.selectedServices.contains('Takeaway'),
          serviceHours: ServiceHours(json: jsonDecode(servicesHoursJson)),
          zoneCode: _currentData.zoneCode,
          municipalityCode: _currentData.municipalityCode,
        ),
        user.accessToken,
      );

      final venue = await venueResult.fold(
        (f) {
          emit(_currentData.copyWith(
              hasError: true, errorMessage: f.errorMessage));
          return null;
        },
        (r) {
          emit(_currentData.copyWith(endingStepIndex: 3));
          return r;
        },
      );
      if (venue == null) return;

      // --- PASO D: Conectar TODAS las fuentes (endingStepIndex: 4) ---
      // Ahora se ejecuta después de crear el Venue y procesa todas las fuentes
      if (dataBefore.connectedSources.isNotEmpty) {
        final datasourceRequests = dataBefore.connectedSources.map((s) {
          return DatasourceRequest(
            dataSourceId: s.id,
            apiKey: (s.id == 3 || s.id == 4 || s.id == 5) ? s.key : '',
            token: (s.id == 1 || s.id == 2) ? s.key : '',
            email: (s.id == 6) ? s.email : '',
            password: (s.id == 6) ? s.password : '',
          );
        }).toList();

        final datasourcesResult = await connectDataSourcesUsecase(
            datasourceRequests, user.accessToken);

        bool hasErrorSources = false;
        datasourcesResult.fold(
          (failure) {
            hasErrorSources = true;
            emit(_currentData.copyWith(
                hasError: true, errorMessage: failure.errorMessage));
          },
          (_) => null,
        );
        if (hasErrorSources) return;
      }
      emit(_currentData.copyWith(endingStepIndex: 4));

      // --- PASO E: Obtener KPIs (endingStepIndex: 5) ---

      final kpisResult = await getKpiListByUser(user.accessToken, user.userId);
      await kpisResult.fold(
        (failure) async {
          emit(_currentData.copyWith(
              hasError: true, errorMessage: failure.errorMessage));
        },
        (kpis) async {
          emit(_currentData.copyWith(
              kpis: kpis,
              selectedKpi: _selectDefaultKpis(kpis),
              endingStepIndex: 5));
        },
      );
    } catch (e) {
      debugPrint('DEBUG: BusinessOnboardingBloc - Error: $e');
      emit(_currentData.copyWith(hasError: true, errorMessage: e.toString()));
    }
  }

 Future<void> _onStartAutomaticConfiguration(StartAutomaticConfiguration event,
    Emitter<BusinessOnboardingState> emit) async {
  final dataBefore = _currentData;
  emit(dataBefore.copyWith(
      hasError: false, errorMessage: null, endingStepIndex: 0));

  try {
    // 1. Obtener Usuario Local
    final userResult = await getLocalUserUsecase();
    final user = userResult.fold((l) => null, (r) => r);
    
    if (user == null) {
      final failure = userResult.fold((l) => l, (r) => null);
      emit(dataBefore.copyWith(
          hasError: true, errorMessage: failure?.errorMessage));
      return;
    }

    await Future.delayed(const Duration(milliseconds: 500));
    emit(_currentData.copyWith(endingStepIndex: 1));

    // --- PASO A: Configuración Automática (Crea Venue/Org/Company) ---
    final autoConfigResult = await startAutoConfigUsecase(
        RequestAutoConfig(
            placeId: dataBefore.businessInformations.first.placeId,
            venueType: _getVenueType(
                dataBefore.businessInformations.first.categories),
            userId: user.userId,
            hasTerrace: dataBefore.hasTerrace,
            terraceTables: dataBefore.exteriorTables,
            terraceChairs: dataBefore.exteriorCapacity,
            interiorTables: dataBefore.interiorTables,
            interiorChairs: dataBefore.interiorCapacity,
            delivery: dataBefore.selectedServices.contains('Delivery'),
            takeaway: dataBefore.selectedServices.contains('Takeaway')),
        user.accessToken);

    final autoConfigResponse = await autoConfigResult.fold(
      (f) {
        emit(_currentData.copyWith(hasError: true, errorMessage: f.errorMessage));
        return null;
      },
      (r) {
        emit(_currentData.copyWith(endingStepIndex: 2));
        return r;
      },
    );

    if (autoConfigResponse == null) return;

    // --- PASO B: Conectar TODAS las fuentes (incluyendo ID 1) ---
    // Este paso ahora se ejecuta después de que el auto-config ha creado el entorno
    if (dataBefore.connectedSources.isNotEmpty) {
      final datasourceRequests = dataBefore.connectedSources.map((s) {
        return DatasourceRequest(
          dataSourceId: s.id,
          apiKey: (s.id == 3 || s.id == 4 || s.id == 5) ? s.key : '',
          // Incluimos ID 1 y 2 en el campo token
          token: (s.id == 1 || s.id == 2) ? s.key : '',
          email: (s.id == 6) ? s.email : '',
          password: (s.id == 6) ? s.password : '',
        );
      }).toList();

      final datasourcesResult = await connectDataSourcesUsecase(
          datasourceRequests, user.accessToken);

      bool hasErrorSources = false;
      datasourcesResult.fold(
        (failure) {
          hasErrorSources = true;
          emit(_currentData.copyWith(
              hasError: true, errorMessage: failure.errorMessage));
        },
        (_) => null,
      );
      
      if (hasErrorSources) return;
    }
    
    emit(_currentData.copyWith(endingStepIndex: 3));

    // --- PASO C: Obtener KPIs ---
    // Ajustamos los índices para que sigan la secuencia lógica
    emit(_currentData.copyWith(endingStepIndex: 4));

    final kpisResult = await getKpiListByUser(user.accessToken, user.userId);

    await kpisResult.fold(
      (failure) async {
        emit(_currentData.copyWith(
            hasError: true, errorMessage: failure.errorMessage));
      },
      (kpis) async {
        emit(_currentData.copyWith(
            kpis: kpis,
            selectedKpi: _selectDefaultKpis(kpis),
            endingStepIndex: 5));
      },
    );

  } catch (e) {
    debugPrint('DEBUG: BusinessOnboardingBloc - Error: $e');
    emit(_currentData.copyWith(hasError: true, errorMessage: e.toString()));
  }
}

  Future<void> _onConfirmKpisSelection(
      ConfirmKpiSelection event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    try {
      emit(dataBefore.copyWith(
          fetchingData: true, hasError: false, errorMessage: null));
      final userResult = await getLocalUserUsecase();
      final user = userResult.fold((l) => null, (r) => r);
      if (user == null) {
        final failure = userResult.fold((l) => l, (r) => null);
        emit(dataBefore.copyWith(
            fetchingData: false,
            hasError: true,
            errorMessage: failure?.errorMessage));
        return;
      }
      final kpiList = dataBefore.selectedKpi
          .map((kp) => RequestKpiPreferences(
                kpiId: kp.id!,
                isActive: true,
              ))
          .toList();
      final kpisResult = await submitKpiPreferences(user.accessToken, kpiList);
      await kpisResult.fold(
        (failure) async {
          emit(dataBefore.copyWith(
              fetchingData: false,
              hasError: true,
              errorMessage: failure.errorMessage));
        },
        (kpis) async {
          emit(dataBefore.copyWith(
            fetchingData: false,
            step: OnboardingStep.configObjetivesGoals,
            hasError: false,
            errorMessage: null,
            endingStepIndex: 0,
          ));
        },
      );
    } catch (e) {
      debugPrint('DEBUG: BusinessOnboardingBloc - Error: $e');
      emit(_currentData.copyWith(
          fetchingData: false, hasError: true, errorMessage: e.toString()));
    }
  }

  Future<void> _onSubmitObjectives(
      SubmitObjectives event, Emitter<BusinessOnboardingState> emit) async {
    final dataBefore = _currentData;
    emit(dataBefore.copyWith(
        fetchingData: true, hasError: false, errorMessage: null));
    try {
      final userResult = await getLocalUserUsecase();
      final user = userResult.fold((l) => null, (r) => r);
      if (user == null) {
        final failure = userResult.fold((l) => l, (r) => null);
        emit(dataBefore.copyWith(
            fetchingData: false,
            hasError: true,
            errorMessage: failure?.errorMessage));
        return;
      }
      final params = RequestGoalsEntity(
          userId: user.userId,
          monthlySalesTarget: event.monthlySalesTarget,
          monthlyClientsTarget: event.monthlyClientsTarget,
          averageTicketTarget: event.averageTicketTarget,
          averageMarginPerDishTarget: event.averageMarginPerDishTarget,
          marginPercentageTarget: event.marginPercentageTarget);
      final goalsResult = await submitGoals(user.accessToken, params);
      await goalsResult.fold(
        (failure) async {
          emit(dataBefore.copyWith(
              fetchingData: false,
              hasError: true,
              errorMessage: failure.errorMessage));
        },
        (goals) async {
          emit(dataBefore.copyWith(
            fetchingData: false,
            step: OnboardingStep.goalsConfirmed,
            hasError: false,
            errorMessage: null,
            endingStepIndex: 0,
          ));
        },
      );
    } catch (e) {
      emit(dataBefore.copyWith(
          fetchingData: false, hasError: true, errorMessage: e.toString()));
    }
  }

  void _onBackToPrevious(
      BackToPrevious event, Emitter<BusinessOnboardingState> emit) {
    final data = _currentData;
    OnboardingStep previousStep = data.step;

    switch (data.step) {
      case OnboardingStep.manualEntry:
      case OnboardingStep.googleReview:
        previousStep = OnboardingStep.googleIntro;
        break;
      case OnboardingStep.googleDataConfirmed:
        previousStep = OnboardingStep.googleReview;
        break;
      case OnboardingStep.manualDataConfirmed:
        previousStep = OnboardingStep.manualEntry;
        break;
      case OnboardingStep.sourcesConfirmed:
        previousStep = OnboardingMethod.manual == data.method
            ? OnboardingStep.manualDataConfirmed
            : OnboardingStep.googleDataConfirmed;
        break;
      case OnboardingStep.businessTypeConfirmed:
        previousStep = OnboardingStep.sourcesConfirmed;
        break;
      case OnboardingStep.timeSchedulesConfirmed:
        previousStep = OnboardingMethod.manual == data.method
            ? OnboardingStep.businessTypeConfirmed
            : OnboardingStep.googleDataConfirmed;
        break;
      case OnboardingStep.localConfigConfirmed:
        previousStep = OnboardingMethod.manual == data.method
            ? OnboardingStep.timeSchedulesConfirmed
            : OnboardingStep.sourcesConfirmed;
        break;
      case OnboardingStep.servicesConfirmed:
        previousStep = OnboardingStep.localConfigConfirmed;
        break;
      case OnboardingStep.kpiSelection:
        previousStep = OnboardingStep.localConfigConfirmed;
        break;
      case OnboardingStep.configObjetivesGoals:
        previousStep = OnboardingStep.kpiSelection;
        break;
      case OnboardingStep.objetivesGoals:
        previousStep = OnboardingStep.configObjetivesGoals;
        break;
      case OnboardingStep.goalsConfirmed:
        previousStep = OnboardingStep.configObjetivesGoals;
        break;
      default:
        break;
    }

    emit(data.copyWith(
      step: previousStep,
      hasError: false,
      errorMessage: null,
    ));
  }

  void _onGoToKpiSelection(
      GoToKpiSelection event, Emitter<BusinessOnboardingState> emit) {
    emit(_currentData.copyWith(step: OnboardingStep.kpiSelection));
  }

  void _onToggleKpi(ToggleKpi event, Emitter<BusinessOnboardingState> emit) {
    final data = _currentData;
    final selectedKpis = List<KpiEntity>.from(data.selectedKpi);

    if (selectedKpis.contains(event.kpi)) {
      selectedKpis.remove(event.kpi);
    } else {
      selectedKpis.add(event.kpi);
    }

    emit(data.copyWith(selectedKpi: selectedKpis));
  }

  void _onChangeKpiFilter(
      ChangeKpiFilter event, Emitter<BusinessOnboardingState> emit) {
    emit(_currentData.copyWith(kpiFilter: event.filter));
  }

  List<KpiEntity> _selectDefaultKpis(List<KpiEntity> kpis) {
    final defaultNames = [
      'beneficio mensual',
      'mercaderias',
      'personal',
      'facturacion total',
      'ticket medio',
    ];

    return kpis.where((kpi) {
      final normalizedName = _normalize(kpi.name ?? '');
      return defaultNames.any((def) => normalizedName.contains(def));
    }).toList();
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');
  }

  FutureOr<void> _onGoToConfigObjetivesGoals(
      GoToConfigObjetivesGoals event, Emitter<BusinessOnboardingState> emit) {
    if (event.isConfigNow) {
      emit(_currentData.copyWith(step: OnboardingStep.objetivesGoals));
    } else {
      emit(_currentData.copyWith(step: OnboardingStep.goalsConfirmed));
    }
  }
}

String? _getVenueType(List<String> categories) {
  if (categories.contains('Restaurante')) {
    return 'restaurante';
  } else if (categories.contains('Bar / Pub')) {
    return 'bar';
  } else if (categories.contains('Cafetería')) {
    return 'cafeteria';
  } else if (categories.contains('Fast casual')) {
    return 'fast casual';
  } else if (categories.contains('Pizzería')) {
    return 'pizzeria';
  }
  return null;
}
