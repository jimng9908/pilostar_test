import 'package:dartz/dartz.dart';
import 'package:rockstardata_apk/app/core/errors/failure.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

abstract class MyBusinessRepository {
  Future<Either<Failure, List<BusinessInformation>>> getBusinessInfo(
      String placeUrl, String accessToken);
  Future<Either<Failure, Organization>> createOrganization(
      String name, String nif, String accessToken);
  Future<Either<Failure, Company>> createCompany(
      RequestCompany requestCompany, String accessToken);
  Future<Either<Failure, ResponseVenue>> createVenue(
      RequestVenue requestVenue, String accessToken);
  Future<Either<Failure, List<DatasourcesResponse>>> connectDataSources(
      List<DatasourceRequest> datasourceRequestModels, String accessToken);
  Future<Either<Failure, ResponseAutoConfig>> startAutomaticConfiguration(
      RequestAutoConfig requestAutoConfig, String accessToken);
  Future<Either<Failure, List<KpiEntity>>> getKpisByUserId(
      String accessToken, int userId);
  Future<Either<Failure, List<ResponseKpiPreferences>>> submitKpiPreferences(
      String accessToken, List<RequestKpiPreferences> kpiModels);
  Future<Either<Failure, ResponseGoalsEntity>> submitGoals(
      String accessToken, RequestGoalsEntity goals);
}
