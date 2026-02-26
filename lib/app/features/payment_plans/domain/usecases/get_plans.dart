import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class GetPlans{
  final PaymentRepository paymentRepository;
  GetPlans({required this.paymentRepository});

  Future<Either<Failure, List<PlanModel>>> call(String accessToken) async {
    return await paymentRepository.getPlans(accessToken);
  }
}
