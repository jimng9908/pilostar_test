import 'package:equatable/equatable.dart';

class PaymentIntentEntity extends Equatable {
  final String clientSecret;
  final String paymentIntentId;

  const PaymentIntentEntity({
    required this.clientSecret,
    required this.paymentIntentId,
  });

  @override
  List<Object?> get props => [clientSecret, paymentIntentId];
}
