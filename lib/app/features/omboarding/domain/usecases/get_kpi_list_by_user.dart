import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class GetKpiListByUser {
  final MyBusinessRepository repository;

  GetKpiListByUser({required this.repository});

  Future<Either<Failure, List<KpiEntity>>> call(String accessToken, int userId) {
    return repository.getKpisByUserId(accessToken, userId);
  }
}