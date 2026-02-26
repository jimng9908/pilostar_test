import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class CheckPaymentSubscriptionStatus {
  final PaymentRepository paymentRepository;
  CheckPaymentSubscriptionStatus({required this.paymentRepository});

  Future<Either<Failure, PaymentSubscriptionStatusEntity>> call(
      String accessToken, String paymentIntentId) async {
    return await paymentRepository.getPaymentSubscriptionStatus(
        accessToken, paymentIntentId);
  }
}
