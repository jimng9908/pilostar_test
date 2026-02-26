import 'package:dartz/dartz.dart' show Either;
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class CreateCompany {
  final MyBusinessRepository repository;

  CreateCompany({required this.repository});

  Future<Either<Failure, Company>> call(RequestCompany params, String accessToken) async {
    return await repository.createCompany(params, accessToken);
  }
}