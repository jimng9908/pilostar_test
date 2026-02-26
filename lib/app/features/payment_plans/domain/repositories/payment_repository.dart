import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PlanModel>>> getPlans(String accessToken);
  Future<Either<Failure, FreeTrialModel>> getFreeTrial(String accessToken);
  Future<Either<Failure, PaymentIntentModel>> createPaymentIntent(
      String accessToken, int planId);
  Future<Either<Failure, PaymentSubscriptionStatusEntity>>
      getPaymentSubscriptionStatus(String accessToken, String paymentIntentId);
  Future<Either<Failure, SubscriptionStatusEntity>> getSubscriptionStatus(
      String accessToken);
}
