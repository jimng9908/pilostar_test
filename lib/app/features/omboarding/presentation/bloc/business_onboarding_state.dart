part of 'business_onboarding_bloc.dart';

enum OnboardingStep {
  googleIntro,
  manualEntry,
  googleReview,
  googleDataConfirmed,
  manualDataConfirmed,
  sourcesConfirmed,
  businessTypeConfirmed,
  timeSchedulesConfirmed,
  servicesConfirmed,
  localConfigConfirmed,
  kpiSelection,
  configObjetivesGoals,
  objetivesGoals,
  goalsConfirmed,
}

abstract class BusinessOnboardingState extends Equatable {
  const BusinessOnboardingState();
  @override
  List<Object?> get props => [];
}

class BusinessOnboardingInitial extends BusinessOnboardingState {}

class BusinessOnboardingLoading extends BusinessOnboardingState {
  final String? message;
  final double? progress;
  final int? stepIndex;
  final bool? isDone;

  const BusinessOnboardingLoading({
    this.message,
    this.progress,
    this.stepIndex,
    this.isDone,
  });

  BusinessOnboardingLoading copyWith({
    String? message,
    double? progress,
    int? stepIndex,
    bool? isDone,
  }) {
    return BusinessOnboardingLoading(
      message: message ?? this.message,
      progress: progress ?? this.progress,
      stepIndex: stepIndex ?? this.stepIndex,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  List<Object?> get props => [message, progress, stepIndex, isDone];
}

class BusinessOnboardingFailure extends BusinessOnboardingState {
  final String message;
  const BusinessOnboardingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// ESTADO PRINCIPAL: Contiene toda la información recolectada
class BusinessOnboardingLoaded extends BusinessOnboardingState {
  final bool fetchingData;
  final OnboardingStep step;
  final OnboardingMethod method;
  final List<BusinessInformation> businessInformations;
  final List<DataSource> connectedSources;
  final List<Map<String, String>> savedGroups;
  final List<String> selectedServices;
  final List<KpiEntity> kpis;
  final List<KpiEntity> selectedKpi;
  final String kpiFilter;
  final ResponseGoalsEntity goals;

  // Datos del formulario manual
  final String name;
  final String address;
  final String? phone;
  final String email;
  final String cif;
  final String businessType;
  final String website;
  final String zoneCode;
  final String municipalityCode;
  final Municipality? selectedMunicipality;

  // Local Config
  final bool hasTerrace;
  final int interiorTables;
  final int interiorCapacity;
  final int exteriorTables;
  final int exteriorCapacity;

  // LastApp Marketplace Handshake Data
  final String? lastAppLocationId;
  final String? lastAppLocationName;
  final String? lastAppCallbackUrl;

  // Control de animación final
  final int endingStepIndex;
  final bool hasError;
  final String? errorMessage;

  const BusinessOnboardingLoaded({
    this.fetchingData = false,
    this.step = OnboardingStep.googleIntro,
    this.method = OnboardingMethod.automatic,
    this.businessInformations = const [],
    this.connectedSources = const [],
    this.savedGroups = const [],
    this.selectedServices = const [],
    this.name = '',
    this.address = '',
    this.phone,
    this.email = '',
    this.cif = '',
    this.businessType = '',
    this.website = '',
    this.zoneCode = '',
    this.municipalityCode = '',
    this.selectedMunicipality,
    this.hasTerrace = false,
    this.interiorTables = 0,
    this.interiorCapacity = 0,
    this.exteriorTables = 0,
    this.exteriorCapacity = 0,
    this.endingStepIndex = 0,
    this.hasError = false,
    this.errorMessage,
    this.kpis = const [],
    this.selectedKpi = const [],
    this.kpiFilter = 'Todos',
    this.goals = const ResponseGoalsEntity.empty(),
    this.lastAppLocationId,
    this.lastAppLocationName,
    this.lastAppCallbackUrl,
  });

  double get progress {
    return (endingStepIndex / 5.0).clamp(0.0, 1.0);
  }

  int get stepIndex => endingStepIndex;

  BusinessOnboardingLoaded copyWith({
    bool? fetchingData,
    OnboardingStep? step,
    OnboardingMethod? method,
    List<BusinessInformation>? businessInformations,
    List<DataSource>? connectedSources,
    List<Map<String, String>>? savedGroups,
    List<String>? selectedServices,
    String? name,
    String? address,
    String? phone,
    String? email,
    String? cif,
    String? businessType,
    String? website,
    String? zoneCode,
    String? municipalityCode,
    Municipality? selectedMunicipality,
    bool? hasTerrace,
    int? interiorTables,
    int? interiorCapacity,
    int? exteriorTables,
    int? exteriorCapacity,
    int? endingStepIndex,
    bool? hasError,
    String? errorMessage,
    List<KpiEntity>? kpis,
    List<KpiEntity>? selectedKpi,
    String? kpiFilter,
    ResponseGoalsEntity? goals,
    String? lastAppLocationId,
    String? lastAppLocationName,
    String? lastAppCallbackUrl,
  }) {
    return BusinessOnboardingLoaded(
      fetchingData: fetchingData ?? this.fetchingData,
      step: step ?? this.step,
      method: method ?? this.method,
      businessInformations: businessInformations ?? this.businessInformations,
      connectedSources: connectedSources ?? this.connectedSources,
      savedGroups: savedGroups ?? this.savedGroups,
      selectedServices: selectedServices ?? this.selectedServices,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      cif: cif ?? this.cif,
      businessType: businessType ?? this.businessType,
      website: website ?? this.website,
      zoneCode: zoneCode ?? this.zoneCode,
      municipalityCode: municipalityCode ?? this.municipalityCode,
      selectedMunicipality: selectedMunicipality ?? this.selectedMunicipality,
      hasTerrace: hasTerrace ?? this.hasTerrace,
      interiorTables: interiorTables ?? this.interiorTables,
      interiorCapacity: interiorCapacity ?? this.interiorCapacity,
      exteriorTables: exteriorTables ?? this.exteriorTables,
      exteriorCapacity: exteriorCapacity ?? this.exteriorCapacity,
      endingStepIndex: endingStepIndex ?? this.endingStepIndex,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      kpis: kpis ?? this.kpis,
      selectedKpi: selectedKpi ?? this.selectedKpi,
      kpiFilter: kpiFilter ?? this.kpiFilter,
      goals: goals ?? this.goals,
      lastAppLocationId: lastAppLocationId ?? this.lastAppLocationId,
      lastAppLocationName: lastAppLocationName ?? this.lastAppLocationName,
      lastAppCallbackUrl: lastAppCallbackUrl ?? this.lastAppCallbackUrl,
    );
  }

  @override
  List<Object?> get props => [
        fetchingData,
        step,
        method,
        businessInformations,
        connectedSources,
        savedGroups,
        selectedServices,
        name,
        address,
        phone,
        email,
        cif,
        businessType,
        website,
        zoneCode,
        municipalityCode,
        selectedMunicipality,
        hasTerrace,
        interiorTables,
        interiorCapacity,
        exteriorTables,
        exteriorCapacity,
        endingStepIndex,
        hasError,
        errorMessage,
        kpis,
        selectedKpi,
        kpiFilter,
        lastAppLocationId,
        lastAppLocationName,
        lastAppCallbackUrl,
      ];
}
