import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/errors/failure.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class StartAutoConfig {
  final MyBusinessRepository repository;

  StartAutoConfig({required this.repository});

  Future<Either<Failure, ResponseAutoConfig>> call(RequestAutoConfig requestAutoConfig, String accessToken) async {
    return await repository.startAutomaticConfiguration(requestAutoConfig, accessToken);
  }
}