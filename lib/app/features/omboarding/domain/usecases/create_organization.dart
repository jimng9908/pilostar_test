import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class CreateOrganization {
  final MyBusinessRepository repository;

  CreateOrganization({required this.repository});

  Future<Either<Failure, Organization>> call(String name, String cif, String accessToken) async {
    return await repository.createOrganization(name, cif, accessToken);
  }
}