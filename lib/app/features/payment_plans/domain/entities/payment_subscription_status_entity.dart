import 'package:equatable/equatable.dart';

class PaymentSubscriptionStatusEntity extends Equatable {
  final bool success;
  final String status;
  final int subscriptionId;
  final String message;

  const PaymentSubscriptionStatusEntity({
    required this.success,
    required this.status,
    required this.subscriptionId,
    required this.message,
  });

  @override
  List<Object?> get props => [success, status, subscriptionId, message];
}
