import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentPlansDataSource paymentPlansDataSource;

  PaymentRepositoryImpl({required this.paymentPlansDataSource});

  @override
  Future<Either<Failure, PaymentIntentModel>> createPaymentIntent(
      String accessToken, int planId) async {
    try {
      final response =
          await paymentPlansDataSource.createPaymentIntent(accessToken, planId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(GenericFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentSubscriptionStatusEntity>>
      getPaymentSubscriptionStatus(
          String accessToken, String paymentIntentId) async {
    try {
      final response = await paymentPlansDataSource
          .getPaymentSubscriptionStatus(accessToken, paymentIntentId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(GenericFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PlanModel>>> getPlans(String accessToken) async {
    try {
      final response = await paymentPlansDataSource.getPlans(accessToken);
      return Right(response);
    } catch (e) {
      return Left(GenericFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FreeTrialModel>> getFreeTrial(
      String accessToken) async {
    try {
      final response = await paymentPlansDataSource.getFreeTrial(accessToken);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(GenericFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscriptionStatusEntity>> getSubscriptionStatus(
      String accessToken) async {
    try {
      final response =
          await paymentPlansDataSource.getSubscriptionStatus(accessToken);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.message));
    } catch (e) {
      return Left(GenericFailure(errorMessage: e.toString()));
    }
  }
}
