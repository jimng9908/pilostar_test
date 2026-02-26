import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class CreatePaymentIntent {
  final PaymentRepository paymentRepository;
  CreatePaymentIntent({required this.paymentRepository});

  Future<Either<Failure, PaymentIntentModel>> call(
      String accessToken, int planId) async {
    return await paymentRepository.createPaymentIntent(accessToken, planId);
  }
}
