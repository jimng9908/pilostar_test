import 'package:dartz/dartz.dart' show Either;
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class CreateVenue {
  final MyBusinessRepository repository;

  CreateVenue({required this.repository});

  Future<Either<Failure, ResponseVenue>> call(RequestVenue params, String accessToken) async {
    return await repository.createVenue(params, accessToken);
  }
}
