import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class CheckSubscriptionsStatus {
  final PaymentRepository paymentRepository;
  CheckSubscriptionsStatus({required this.paymentRepository});

  Future<Either<Failure, SubscriptionStatusEntity>> call(
      String accessToken) async {
    return await paymentRepository.getSubscriptionStatus(accessToken);
  }
}
