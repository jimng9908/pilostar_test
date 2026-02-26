import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

part 'payment_plans_event.dart';
part 'payment_plans_state.dart';

class PaymentPlansBloc extends Bloc<PaymentPlansEvent, PaymentPlansState> {
  final GetPlans getPlans;
  final CreatePaymentIntent createPaymentIntent;
  final CheckPaymentSubscriptionStatus checkPaymentSubscriptionStatus;
  final StartFreeTrial startFreeTrial;
  final GetLocalUserUsecase getLocalUserUsecase;
  final CheckSubscriptionsStatus checkSuscriptionsStatus;

  PaymentPlansBloc({
    required this.getPlans,
    required this.createPaymentIntent,
    required this.checkPaymentSubscriptionStatus,
    required this.startFreeTrial,
    required this.getLocalUserUsecase,
    required this.checkSuscriptionsStatus,
  }) : super(const PaymentPlansState()) {
    on<GetPlansEvent>(_onGetPlans);
    on<StartFreeTrialEvent>(_onStartFreeTrial);
    on<ChangePageEvent>(_onChangePage);
    on<CreatePaymentIntentEvent>(_onCreatePaymentIntent);
    on<CheckPaymentSubscriptionStatusEvent>(_onCheckPaymentSubscriptionStatus);
    on<CheckSubscriptionStatusEvent>(_onCheckSubscriptionStatus);
    on<SelectPlanEvent>(_onSelectPlan);
    on<ToggleStripePaymentEvent>(_onToggleStripePayment);
  }

  void _onToggleStripePayment(
      ToggleStripePaymentEvent event, Emitter<PaymentPlansState> emit) {
    emit(state.copyWith(useStripe: !state.useStripe));
  }

  void _onSelectPlan(SelectPlanEvent event, Emitter<PaymentPlansState> emit) {
    final newSelectedId =
        state.selectedPlanId == event.planId ? null : event.planId;
    emit(state.copyWith(selectedPlanId: newSelectedId));
  }

  void _onChangePage(ChangePageEvent event, Emitter<PaymentPlansState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  void _onGetPlans(GetPlansEvent event, Emitter<PaymentPlansState> emit) async {
    emit(state.copyWith(isLoading: true, isPaymentError: false));
    final userResult = await getLocalUserUsecase();

    await userResult.fold(
      (failure) async => emit(state.copyWith(
          isLoading: false,
          isPaymentError: true,
          errorMessage: failure.errorMessage)),
      (user) async {
        if (user == null) {
          emit(state.copyWith(
              isLoading: false,
              isPaymentError: true,
              errorMessage: "User not found"));
          return;
        }

        final result = await getPlans(user.accessToken);

        result.fold(
          (failure) => emit(state.copyWith(
              isLoading: false,
              isPaymentError: true,
              errorMessage: failure.errorMessage)),
          (plans) => emit(state.copyWith(
            isLoading: false,
            plans: plans,
          )),
        );
      },
    );
  }

  void _onStartFreeTrial(
      StartFreeTrialEvent event, Emitter<PaymentPlansState> emit) async {
    emit(state.copyWith(
      isPaymentProcessing: true,
      isPaymentError: false,
      clientSecret: '', // Limpiamos secreto anterior
      paymentIntentId: '', // Limpiamos ID anterior
      paymentStatus: null, // Reset de status de pago
    ));
    final userResult = await getLocalUserUsecase();

    await userResult.fold(
      (failure) async => emit(state.copyWith(
          isPaymentProcessing: false,
          isPaymentError: true,
          errorMessage: failure.errorMessage)),
      (user) async {
        if (user == null) {
          emit(state.copyWith(
              isPaymentProcessing: false,
              isPaymentError: true,
              errorMessage: "User not found"));
          return;
        }

        final result = await startFreeTrial(user.accessToken);
        await result.fold(
          (failure) async => emit(state.copyWith(
              isPaymentProcessing: false,
              isPaymentError: true,
              errorMessage: failure.errorMessage)),
          (freeTrial) async {
            final statusResult =
                await checkSuscriptionsStatus(user.accessToken);
            statusResult.fold(
              (_) => emit(state.copyWith(isPaymentProcessing: false)),
              (status) => emit(state.copyWith(
                  isPaymentProcessing: false, subscriptionStatus: status)),
            );
          },
        );
      },
    );
  }

  void _onCreatePaymentIntent(
      CreatePaymentIntentEvent event, Emitter<PaymentPlansState> emit) async {
    emit(state.copyWith(
      isPaymentProcessing: true,
      errorMessage: null,
      paymentStatus: null, // <--- Limpiamos status anterior
      useStripe: true,
    ));

    final userResult = await getLocalUserUsecase();

    await userResult.fold(
      (failure) async => emit(state.copyWith(
          isPaymentProcessing: false, errorMessage: failure.errorMessage)),
      (user) async {
        if (user == null) {
          emit(state.copyWith(
              isPaymentProcessing: false, errorMessage: "User not found"));
          return;
        }

        final result =
            await createPaymentIntent(user.accessToken, event.planId);
        result.fold(
          (failure) => emit(state.copyWith(
              isPaymentProcessing: false,
              isPaymentError: true,
              errorMessage: failure.errorMessage)),
          (intent) => emit(state.copyWith(
            clientSecret: intent.clientSecret,
            paymentIntentId: intent.paymentIntentId,
            isPaymentProcessing: false,
          )),
        );
      },
    );
  }

  void _onCheckPaymentSubscriptionStatus(
      CheckPaymentSubscriptionStatusEvent event,
      Emitter<PaymentPlansState> emit) async {
    final userResult = await getLocalUserUsecase();

    await userResult.fold(
      (failure) async =>
          emit(state.copyWith(errorMessage: failure.errorMessage)),
      (user) async {
        if (user == null) {
          emit(state.copyWith(errorMessage: "User not found"));
          return;
        }

        final result = await checkPaymentSubscriptionStatus(
            user.accessToken, event.paymentIntentId);

        await result.fold(
          (failure) async => emit(state.copyWith(
              isPaymentError: true, errorMessage: failure.errorMessage)),
          (paymentStatus) async {
            SubscriptionStatusEntity? fullStatus;

            if (paymentStatus.status == 'succeeded') {
              final statusResult =
                  await checkSuscriptionsStatus(user.accessToken);
              fullStatus = statusResult.fold((_) => null, (s) => s);
            }

            emit(state.copyWith(
              paymentStatus: paymentStatus,
              subscriptionStatus: fullStatus ?? state.subscriptionStatus,
            ));
          },
        );
      },
    );
  }

  FutureOr<void> _onCheckSubscriptionStatus(CheckSubscriptionStatusEvent event,
      Emitter<PaymentPlansState> emit) async {
    final userResult = await getLocalUserUsecase();

    await userResult.fold(
      (failure) async => emit(state.copyWith(
          isPaymentError: true, errorMessage: failure.errorMessage)),
      (user) async {
        if (user == null) {
          emit(state.copyWith(
              isPaymentError: true, errorMessage: "User not found"));
          return;
        }

        final result = await checkSuscriptionsStatus(user.accessToken);

        result.fold(
          (failure) => emit(state.copyWith(
              isPaymentError: true, errorMessage: failure.errorMessage)),
          (status) => emit(state.copyWith(subscriptionStatus: status)),
        );
      },
    );
  }
}
