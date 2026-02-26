import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class StartFreeTrial {
  final PaymentRepository paymentRepository;

  StartFreeTrial({required this.paymentRepository});

  Future<Either<Failure, FreeTrialModel>> call(String accessToken) async {
    return await paymentRepository.getFreeTrial(accessToken);
  }
}