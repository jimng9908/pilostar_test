import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

void initSharedInjection(GetIt sl) {
  // Data sources

  // Repositories

  // Use cases

  // Blocs

  sl.registerFactory<NetworkCubit>(
    () => NetworkCubit(),
  );
  sl.registerFactoryParam<StepperBloc, int, void>(
      (maxSteps, _) => StepperBloc(maxSteps: maxSteps));
  sl.registerLazySingleton(() => ScheduleBloc());
  sl.registerFactory(() => WebViewBloc());
}
