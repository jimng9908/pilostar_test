import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/injection.dart';

class GoogleImportPage extends StatelessWidget {
  const GoogleImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final methodStr = GoRouterState.of(context).uri.queryParameters['method'];
    final method = methodStr == 'manual'
        ? OnboardingMethod.manual
        : OnboardingMethod.automatic;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<StepperBloc>(
              param1:
                  6), // Iniciamos con 6 por defecto (automatic) o se actualizará en el listener
        ),
        BlocProvider(
          create: (context) =>
              sl<BusinessOnboardingBloc>()..add(StartOnboarding(method)),
        ),
        BlocProvider.value(value: sl<ScheduleBloc>()),
      ],
      child: const Content(),
    );
  }

  static int getTotalSteps(OnboardingMethod method) {
    return (method == OnboardingMethod.manual) ? 8 : 7;
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OmboardingAppBar(
        showBackButton: true,
        isRootPage: false,
        onBackPressed: () =>
            context.read<BusinessOnboardingBloc>().add(BackToPrevious()),
      ),
      body: BlocConsumer<BusinessOnboardingBloc, BusinessOnboardingState>(
        listenWhen: (prev, curr) {
          if (prev is BusinessOnboardingLoaded &&
              curr is BusinessOnboardingLoaded) {
            return prev.method != curr.method ||
                prev.step != curr.step ||
                prev.hasError != curr.hasError;
          }
          return curr is BusinessOnboardingLoaded ||
              curr is BusinessOnboardingFailure;
        },
        listener: (context, state) {
          if (state is BusinessOnboardingLoaded) {
            context.read<StepperBloc>().add(
                UpdateTotalSteps(GoogleImportPage.getTotalSteps(state.method)));
          }

          if (state is BusinessOnboardingFailure) {
            CustomNotification.show(
              context,
              title: 'Error',
              message: state.message,
              type: NotificationType.error,
            );
            return;
          }
          if (state is BusinessOnboardingLoaded && state.hasError) {
            CustomNotification.show(
              context,
              title: 'Error',
              message: state.errorMessage!,
              type: NotificationType.error,
            );
            return;
          }

          if (state is BusinessOnboardingLoaded && !state.hasError) {
            context
                .read<StepperBloc>()
                .add(StepTapped(getStepIndex(state, state.method)));

            if (state.step == OnboardingStep.servicesConfirmed &&
                state.endingStepIndex == 0) {
              state.method == OnboardingMethod.manual
                  ? context
                      .read<BusinessOnboardingBloc>()
                      .add(StartConfiguration())
                  : context
                      .read<BusinessOnboardingBloc>()
                      .add(StartAutomaticConfiguration());
            }
          }
          if (state is BusinessOnboardingLoaded && !state.hasError) {
            if (state.step == OnboardingStep.goalsConfirmed) {
              context.pushNamed(RouteName.plans);
            }
          }
        },
        buildWhen: (prev, curr) {
          // If the type of state changes, we MUST rebuild (e.g., Loading -> Loaded)
          if (prev.runtimeType != curr.runtimeType) {
            return true;
          }

          // If both are Loaded, check for specific meaningful property changes
          if (prev is BusinessOnboardingLoaded &&
              curr is BusinessOnboardingLoaded) {
            return prev.step != curr.step ||
                prev.method != curr.method ||
                prev.hasError != curr.hasError;
          }

          // If both are Loading, rebuild only if switching views
          if (prev is BusinessOnboardingLoading &&
              curr is BusinessOnboardingLoading) {
            return (prev.stepIndex == null && curr.stepIndex != null) ||
                (prev.stepIndex != null && curr.stepIndex == null);
          }

          return false;
        },
        builder: (context, state) {
          final isLoading = state is BusinessOnboardingLoading;
          return BlocBuilder<StepperBloc, StepperState>(
            builder: (context, stepperState) {
              return SafeArea(
                  bottom: true,
                  child: Column(
                    children: [
                      isLoading ||
                              state is BusinessOnboardingLoaded &&
                                  state.step == OnboardingStep.servicesConfirmed
                          ? const SizedBox.shrink()
                          : const AnimatedStepProgress(),
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(overscroll: false),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                switchInCurve: Curves.easeInOut,
                                switchOutCurve: Curves.easeInOut,
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  final isForward = stepperState.isForward;

                                  final inAnimation = Tween<Offset>(
                                    begin: Offset(
                                        isLoading || isForward ? 1.0 : -1.0,
                                        0.0),
                                    end: Offset.zero,
                                  ).animate(animation);

                                  final outAnimation = Tween<Offset>(
                                    begin: Offset(isForward ? -1.0 : 1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation);

                                  if (child.key == ValueKey(state.hashCode)) {
                                    return SlideTransition(
                                      position: inAnimation,
                                      child: child,
                                    );
                                  } else {
                                    return SlideTransition(
                                      position: outAnimation,
                                      child: child,
                                    );
                                  }
                                },
                                child: buildView(
                                  state,
                                  (state is BusinessOnboardingLoaded)
                                      ? state.method
                                      : OnboardingMethod.automatic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
            },
          );
        },
      ),
    );
  }

  Widget buildView(BusinessOnboardingState state, OnboardingMethod method) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final key = ValueKey(state.hashCode);

    if (state is BusinessOnboardingLoading) {
      if (state.stepIndex != null) {
        return EndingConfig(key: key);
      }
      return FetchingGoogleData(key: key);
    }

    // 2. Estado Principal Cargado
    if (state is BusinessOnboardingLoaded) {
      switch (state.step) {
        case OnboardingStep.googleIntro:
          return GoogleImportCard(key: key, formKey: formKey);

        case OnboardingStep.manualEntry:
          return ManualFormData(
            key: key,
            formKey: formKey,
            initialName: state.name,
            initialAddress: state.address,
            initialPhone: state.phone,
            initialEmail: state.email,
            initialCif: state.cif,
            initialWebsite: state.website,
            initialMunicipio: state.selectedMunicipality,
          );

        case OnboardingStep.googleReview:
          return ImportFromGoogle(key: key);

        case OnboardingStep.googleDataConfirmed:
        case OnboardingStep.manualDataConfirmed:
          return SourcesSelection(key: key);

        case OnboardingStep.sourcesConfirmed:
          return method == OnboardingMethod.manual
              ? BusinessTypeSelection(key: key)
              : SunruffSelection(key: key);

        case OnboardingStep.businessTypeConfirmed:
          return ScheduleViewSelector(key: key);
        case OnboardingStep.timeSchedulesConfirmed:
          return SunruffSelection(key: key);
        case OnboardingStep.localConfigConfirmed:
          return ServicesSelection(key: key);
        case OnboardingStep.servicesConfirmed:
          return EndingConfig(key: key);
        case OnboardingStep.kpiSelection:
          return KpiListSelector(key: key);
        case OnboardingStep.configObjetivesGoals:
          return ConfigObjetivesGoals(key: key);
        case OnboardingStep.objetivesGoals:
        case OnboardingStep.goalsConfirmed:
          return ObjectivesGoals(
            key: key,
            initialGoals: state.goals,
          );
      }
    }

    // Estado Inicial por defecto
    return SizedBox.shrink(key: key);
  }

  int getStepIndex(BusinessOnboardingLoaded state, OnboardingMethod method) {
    switch (state.step) {
      case OnboardingStep.googleIntro:
      case OnboardingStep.manualEntry:
        return 0;
      case OnboardingStep.googleReview:
      case OnboardingStep.manualDataConfirmed:
        return 1;
      case OnboardingStep.googleDataConfirmed:
        return 2;
      case OnboardingStep.sourcesConfirmed:
        return OnboardingMethod.manual == method ? 2 : 3;
      case OnboardingStep.businessTypeConfirmed:
        return 3;
      case OnboardingStep.timeSchedulesConfirmed:
        return 4;
      case OnboardingStep.localConfigConfirmed:
      case OnboardingStep.servicesConfirmed:
        return OnboardingMethod.manual == method ? 5 : 4;
      case OnboardingStep.kpiSelection:
        return OnboardingMethod.manual == method ? 6 : 5;
      case OnboardingStep.configObjetivesGoals:
      case OnboardingStep.objetivesGoals:
      case OnboardingStep.goalsConfirmed:
        return OnboardingMethod.manual == method ? 7 : 6;
    }
  }
}
