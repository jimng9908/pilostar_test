part of 'payment_plans_bloc.dart';

class PaymentPlansState extends Equatable {
  final bool isPaymentProcessing;
  final String clientSecret;
  final String paymentIntentId;
  final String? errorMessage;
  final bool isPaymentError;
  final bool? isLoading;
  final List<PlanModel>? plans;
  final int currentIndex;
  final int? selectedPlanId;
  final bool useStripe;
  final PaymentSubscriptionStatusEntity? paymentStatus;
  final SubscriptionStatusEntity? subscriptionStatus;

  const PaymentPlansState({
    this.isPaymentProcessing = false,
    this.clientSecret = '',
    this.paymentIntentId = '',
    this.isLoading = false,
    this.errorMessage,
    this.isPaymentError = false,
    this.plans,
    this.currentIndex = 0,
    this.selectedPlanId,
    this.useStripe = false,
    this.paymentStatus,
    this.subscriptionStatus,
  });

  PaymentPlansState copyWith({
    final bool? isPaymentProcessing,
    String? clientSecret,
    String? paymentIntentId,
    String? errorMessage,
    bool? isPaymentError,
    bool? isLoading,
    List<PlanModel>? plans,
    int? currentIndex,
    int? selectedPlanId,
    bool? useStripe,
    PaymentSubscriptionStatusEntity? paymentStatus,
    SubscriptionStatusEntity? subscriptionStatus,
  }) {
    return PaymentPlansState(
      isPaymentProcessing: isPaymentProcessing ?? this.isPaymentProcessing,
      clientSecret: clientSecret ?? this.clientSecret,
      paymentIntentId: paymentIntentId ?? this.paymentIntentId,
      errorMessage: errorMessage ?? this.errorMessage,
      isPaymentError: isPaymentError ?? this.isPaymentError,
      isLoading: isLoading ?? this.isLoading,
      plans: plans ?? this.plans,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      useStripe: useStripe ?? this.useStripe,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
    );
  }

  @override
  List<Object?> get props => [
        isPaymentProcessing,
        clientSecret,
        paymentIntentId,
        isLoading,
        errorMessage,
        isPaymentError,
        plans,
        currentIndex,
        selectedPlanId,
        useStripe,
        paymentStatus,
        subscriptionStatus,
      ];
}
