import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class SubmitGoals {
  final MyBusinessRepository repository;

  SubmitGoals({required this.repository});

  Future<Either<Failure, ResponseGoalsEntity>> call(String accessToken, RequestGoalsEntity params) async {
    return repository.submitGoals(accessToken, params);
  }
}