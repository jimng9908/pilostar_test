import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/auth/domain/usecases/get_local_user.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

void initPaymentInjection(GetIt sl) {
  //DataSources
  sl.registerLazySingleton<PaymentPlansDataSource>(
      () => PaymentPlansDataSourceImpl());

  //Repository
  sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(
        paymentPlansDataSource: sl(),
      ));

  //Usecases
  sl.registerLazySingleton<GetPlans>(() => GetPlans(
        paymentRepository: sl(),
      ));
  sl.registerLazySingleton<CreatePaymentIntent>(() => CreatePaymentIntent(
        paymentRepository: sl(),
      ));
  sl.registerLazySingleton<CheckPaymentSubscriptionStatus>(
      () => CheckPaymentSubscriptionStatus(
            paymentRepository: sl(),
          ));
  sl.registerLazySingleton<StartFreeTrial>(() => StartFreeTrial(
        paymentRepository: sl(),
      ));
  sl.registerLazySingleton<CheckSubscriptionsStatus>(
      () => CheckSubscriptionsStatus(
            paymentRepository: sl(),
          ));

  //Blocs
  sl.registerLazySingleton<PaymentPlansBloc>(() => PaymentPlansBloc(
        getPlans: sl<GetPlans>(),
        startFreeTrial: sl<StartFreeTrial>(),
        createPaymentIntent: sl<CreatePaymentIntent>(),
        checkPaymentSubscriptionStatus: sl<CheckPaymentSubscriptionStatus>(),
        checkSuscriptionsStatus: sl<CheckSubscriptionsStatus>(),
        getLocalUserUsecase: sl<GetLocalUserUsecase>(),
      )
        ..add(GetPlansEvent())
        ..add(CheckSubscriptionStatusEvent()));
}
