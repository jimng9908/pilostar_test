import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ConnectDataSources {
  final MyBusinessRepository repository;

  ConnectDataSources({required this.repository});

  Future<Either<Failure, List<DatasourcesResponse>>> call(
      List<DatasourceRequest> params, String accessToken) async {
    return await repository.connectDataSources(params, accessToken);
  }
}
