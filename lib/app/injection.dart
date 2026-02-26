import 'dart:io';
import 'package:rockstardata_apk/app/features/chat_bot/index.dart';
import 'package:rockstardata_apk/app/features/home/index.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/chat_bot/di/chat_injection.dart';
import 'package:rockstardata_apk/app/features/finanzas/di/finance_injection.dart';
import 'package:rockstardata_apk/app/features/home/dashboard_injection.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/profile/di/profile_injection.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

import 'features/payment_plans/di/payment_injection.dart';
import 'features/shared/di/shared_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Configuración de Dio con seguridad
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();

    // Configurar opciones
    dio.options = BaseOptions(
      baseUrl: Constants.baseAuthUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    // Configurar adapter para cada plataforma
    if (Platform.isAndroid || Platform.isIOS) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();

          // Configuración específica para móvil
          client.badCertificateCallback = (cert, host, port) {
            // Solo en desarrollo, quitar en producción
            if (kDebugMode) {
              debugPrint('Accepting certificate for $host');
              return true;
            }
            return false; // En producción, validar certificados
          };

          // Timeouts específicos
          client.connectionTimeout = const Duration(seconds: 30);
          client.idleTimeout = const Duration(seconds: 30);

          return client;
        },
      );
    }

    // Interceptores - el TokenInterceptor primero
    dio.interceptors.addAll([
      // TokenInterceptor debe ir primero
      TokenInterceptor(dio: dio, authLocalDataSource: sl()),

      // Log interceptor (solo desarrollo)
      if (kDebugMode)
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (log) => debugPrint('DIO: $log'),
        ),

      // QueuedInterceptor al final
      QueuedInterceptorsWrapper(),
    ]);

    return dio;
  }, instanceName: 'authDio');

  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    ),
  );

  sl.registerFactory(() => RouterCubit());

  initAuthInjection(sl);
  initOnboardingInjection(sl);
  initPaymentInjection(sl);
  dashboardInjection(sl);
  initChatInjection(sl);
  initFinanceInjection(sl);
  initProfileInjection(sl);
  initSharedInjection(sl);
}

void resetUserBlocs() {
  // Cerramos y eliminamos las instancias de los Blocs que son Singletons
  // Esto hace que la próxima vez que se pidan, se creen de nuevo con su estado inicial.
  // PaymentPlansBloc se provee en la raíz (main) y no se resetea aquí para evitar
  // cerrar el mismo instance que usa el árbol; el estado se refresca al hacer login.
  if (sl.isRegistered<DashboardBloc>()) {
    sl.get<DashboardBloc>().close();
    sl.resetLazySingleton<DashboardBloc>();
  }
  if (sl.isRegistered<ChatBotBloc>()) {
    sl.get<ChatBotBloc>().close();
    sl.resetLazySingleton<ChatBotBloc>();
  }
  if (sl.isRegistered<ProfileBloc>()) {
    sl.get<ProfileBloc>().close();
    sl.resetLazySingleton<ProfileBloc>();
  }
  if (sl.isRegistered<ScheduleBloc>()) {
    sl.get<ScheduleBloc>().close();
    sl.resetLazySingleton<ScheduleBloc>();
  }
  // WebViewBloc se registra como factory, no como LazySingleton,
  // por lo que no se debe llamar a resetLazySingleton sobre él.
}
