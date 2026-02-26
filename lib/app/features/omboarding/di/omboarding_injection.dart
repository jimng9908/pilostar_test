import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

void initOnboardingInjection(GetIt sl) {
  // Data sources
  sl.registerLazySingleton<MyBusinessRemoteDataSource>(
    () => MyBusinessRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<MyBusinessRepository>(
    () => MyBusinessRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetBusinessInformation(repository: sl()));
  sl.registerLazySingleton(() => CreateOrganization(repository: sl()));
  sl.registerLazySingleton(() => CreateCompany(repository: sl()));
  sl.registerLazySingleton(() => CreateVenue(repository: sl()));
  sl.registerLazySingleton(() => ConnectDataSources(repository: sl()));
  sl.registerLazySingleton(() => StartAutoConfig(repository: sl()));
  sl.registerLazySingleton(() => GetKpiListByUser(repository: sl()));
  sl.registerLazySingleton(() => SubmitKpiPreferences(repository: sl()));
  sl.registerLazySingleton(() => SubmitGoals(repository: sl()));

  // Blocs
  sl.registerFactory(
    () => BusinessOnboardingBloc(
      getBusinessInformation: sl(),
      getLocalUserUsecase: sl(),
      createOrganizationUsecase: sl(),
      createCompanyUsecase: sl(),
      createVenueUsecase: sl(),
      connectDataSourcesUsecase: sl(),
      startAutoConfigUsecase: sl(),
      getKpiListByUser: sl(),
      submitKpiPreferences: sl(),
      submitGoals: sl(),
    ),
  );
}
