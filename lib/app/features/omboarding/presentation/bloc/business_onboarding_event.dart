part of 'business_onboarding_bloc.dart';

enum OnboardingMethod { automatic, manual }

abstract class BusinessOnboardingEvent extends Equatable {
  const BusinessOnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends BusinessOnboardingEvent {
  final OnboardingMethod method;
  const StartOnboarding(this.method);

  @override
  List<Object?> get props => [method];
}

class GoToManualEntry extends BusinessOnboardingEvent {}

class ImportGoogleData extends BusinessOnboardingEvent {
  final String placeUrl;
  const ImportGoogleData({required this.placeUrl});

  @override
  List<Object?> get props => [placeUrl];
}

class ConfirmGoogleData extends BusinessOnboardingEvent {}

class ConfirmSources extends BusinessOnboardingEvent {}

class SubmitManualData extends BusinessOnboardingEvent {
  final String name;
  final String address;
  final String? phone;
  final String email;
  final String cif;
  final String website;
  final String? zoneCode;
  final String? municipalityCode;
  final Municipality? selectedMunicipality;

  const SubmitManualData({
    required this.name,
    required this.address,
    this.phone,
    required this.email,
    required this.cif,
    required this.website,
    this.zoneCode,
    this.municipalityCode,
    this.selectedMunicipality,
  });

  @override
  List<Object?> get props => [
        name,
        address,
        phone,
        email,
        cif,
        website,
        zoneCode,
        municipalityCode,
        selectedMunicipality
      ];
}

class BuisinessTypeSelected extends BusinessOnboardingEvent {
  final String businessType;

  const BuisinessTypeSelected({
    required this.businessType,
  });

  @override
  List<Object?> get props => [businessType];
}

class SubmitBusinessType extends BusinessOnboardingEvent {
  final String businessType;

  const SubmitBusinessType({
    required this.businessType,
  });

  @override
  List<Object?> get props => [businessType];
}

class SubmitServices extends BusinessOnboardingEvent {
  final List<String> services;

  const SubmitServices({
    required this.services,
  });

  @override
  List<Object?> get props => [services];
}

class ToggleService extends BusinessOnboardingEvent {
  final String service;
  const ToggleService(this.service);

  @override
  List<Object?> get props => [service];
}

class SaveTimeSchedulesEvent extends BusinessOnboardingEvent {
  final List<Map<String, String>> savedGroups;

  const SaveTimeSchedulesEvent({required this.savedGroups});

  @override
  List<Object?> get props => [savedGroups];
}

class ConnectSources extends BusinessOnboardingEvent {
  final int sourceId;
  final String? apiKey;
  final String? sourceName;
  final String? email;
  final String? password;
  final String? lastAppLocationId;
  final String? lastAppLocationName;
  final String? lastAppCallbackUrl;

  const ConnectSources({
    required this.sourceId,
    this.apiKey,
    this.sourceName,
    this.email,
    this.password,
    this.lastAppLocationId,
    this.lastAppLocationName,
    this.lastAppCallbackUrl,
  });

  @override
  List<Object?> get props => [
        sourceId,
        apiKey,
        sourceName,
        email,
        password,
        lastAppLocationId,
        lastAppLocationName,
        lastAppCallbackUrl,
      ];
}

class DisconnectSources extends BusinessOnboardingEvent {
  final int sourceId;
  const DisconnectSources({required this.sourceId});

  @override
  List<Object?> get props => [sourceId];
}

class StartConfiguration extends BusinessOnboardingEvent {}

class StartAutomaticConfiguration extends BusinessOnboardingEvent {}

class ConfirmKpiSelection extends BusinessOnboardingEvent {}

class SubmitObjectives extends BusinessOnboardingEvent {
  final double monthlySalesTarget;
  final int monthlyClientsTarget;
  final double averageTicketTarget;
  final double averageMarginPerDishTarget;
  final double marginPercentageTarget;

  const SubmitObjectives({
    required this.monthlySalesTarget,
    required this.monthlyClientsTarget,
    required this.averageTicketTarget,
    required this.averageMarginPerDishTarget,
    required this.marginPercentageTarget,
  });

  @override
  List<Object?> get props => [
        monthlySalesTarget,
        monthlyClientsTarget,
        averageTicketTarget,
        averageMarginPerDishTarget,
        marginPercentageTarget,
      ];
}

class ToggleTerrace extends BusinessOnboardingEvent {
  final bool hasTerrace;
  const ToggleTerrace(this.hasTerrace);

  @override
  List<Object?> get props => [hasTerrace];
}

class UpdateLocalConfig extends BusinessOnboardingEvent {
  final int? interiorTables;
  final int? interiorCapacity;
  final int? exteriorTables;
  final int? exteriorCapacity;

  const UpdateLocalConfig({
    this.interiorTables,
    this.interiorCapacity,
    this.exteriorTables,
    this.exteriorCapacity,
  });

  @override
  List<Object?> get props => [
        interiorTables,
        interiorCapacity,
        exteriorTables,
        exteriorCapacity,
      ];
}

class ConfirmLocalConfig extends BusinessOnboardingEvent {}

class GoToKpiSelection extends BusinessOnboardingEvent {}

class ToggleKpi extends BusinessOnboardingEvent {
  final KpiEntity kpi;
  const ToggleKpi(this.kpi);

  @override
  List<Object?> get props => [kpi];
}

class ChangeKpiFilter extends BusinessOnboardingEvent {
  final String filter;
  const ChangeKpiFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

class GoToConfigObjetivesGoals extends BusinessOnboardingEvent {
  final bool isConfigNow;
  const GoToConfigObjetivesGoals({required this.isConfigNow});

  @override
  List<Object?> get props => [isConfigNow];
}

class BackToPrevious extends BusinessOnboardingEvent {}
