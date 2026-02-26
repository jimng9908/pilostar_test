import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class SubmitKpiPreferences {
  final MyBusinessRepository repository;

  SubmitKpiPreferences({required this.repository});

  Future<Either<Failure, List<ResponseKpiPreferences>>> call(String accessToken, List<RequestKpiPreferences> kpiModels) async {
    return repository.submitKpiPreferences(accessToken, kpiModels);
  }
}