import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';

Future<void> initAuthInjection(GetIt sl) async {
  // DataSources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl()),
  );

  sl.registerLazySingleton<GoogleAuthService>(() => GoogleAuthService());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl<Dio>(instanceName: 'authDio'),
      googleAuthService: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUserUsecase(sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUserUseCases(sl()));
  sl.registerLazySingleton(() => RegisterWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => GetLocalUserUsecase(sl()));
  sl.registerLazySingleton(() => SaveLocalUserUsecase(sl()));
  sl.registerLazySingleton(() => CleanDataUsecase(sl()));
  sl.registerLazySingleton(() => VerifyBusinessConfig(sl()));
  sl.registerLazySingleton(() => VerifyCode(sl()));

  // Blocs
  sl.registerLazySingleton(() => AuthBloc(
        loginUser: sl(),
        loginWithGoogle: sl(),
        registerUser: sl(),
        verifyCode: sl(),
        registerWithGoogle: sl(),
        getLocalUser: sl(),
        saveLocalUser: sl(),
        cleanData: sl(),
        verifyBusinessConfig: sl(),
      ));
}
