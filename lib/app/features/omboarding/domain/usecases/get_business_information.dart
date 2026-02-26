import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/errors/failure.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class GetBusinessInformation {
  final MyBusinessRepository repository;

  GetBusinessInformation({required this.repository});

  Future<Either<Failure, List<BusinessInformation>>> call(String placeUrl, String accessToken) async {
    return await repository.getBusinessInfo(placeUrl, accessToken);
  }
}
