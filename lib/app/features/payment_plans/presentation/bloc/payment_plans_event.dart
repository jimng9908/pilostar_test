part of 'payment_plans_bloc.dart';

abstract class PaymentPlansEvent extends Equatable {
  const PaymentPlansEvent();

  @override
  List<Object> get props => [];
}

class GetPlansEvent extends PaymentPlansEvent {}

class StartFreeTrialEvent extends PaymentPlansEvent {}

class ChangePageEvent extends PaymentPlansEvent {
  final int index;
  const ChangePageEvent(this.index);

  @override
  List<Object> get props => [index];
}

class CreatePaymentIntentEvent extends PaymentPlansEvent {
  final int planId;
  const CreatePaymentIntentEvent(this.planId);

  @override
  List<Object> get props => [planId];
}

class CheckPaymentSubscriptionStatusEvent extends PaymentPlansEvent {
  final String paymentIntentId;
  const CheckPaymentSubscriptionStatusEvent(this.paymentIntentId);

  @override
  List<Object> get props => [paymentIntentId];
}

class CheckSubscriptionStatusEvent extends PaymentPlansEvent {}

class SelectPlanEvent extends PaymentPlansEvent {
  final int planId;
  const SelectPlanEvent(this.planId);

  @override
  List<Object> get props => [planId];
}

class ToggleStripePaymentEvent extends PaymentPlansEvent {
  const ToggleStripePaymentEvent();

  @override
  List<Object> get props => [];
}
