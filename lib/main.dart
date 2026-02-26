import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/rockstardata_app.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';
import 'package:rockstardata_apk/app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rockstardata_apk/firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'app/rockstardata_observer.dart';

void main() async {
  //Initialize GetIt
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await init();
    tz.initializeTimeZones();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Barra transparente
      statusBarIconBrightness: Brightness.light, // Íconos claros
    ));

    //! https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
    tz.setLocalLocation(tz.getLocation('Europe/Madrid'));

    Bloc.observer = RockStarDataObserver();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await flutterLocalNotificationsPlugin.initialize(settings: settings);

    configEasyLoading();
    HttpOverrides.global = MyHttpOverrides();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Stripe
    Stripe.publishableKey = Constants.stripePublishableKey;
    await Stripe.instance.applySettings();
  } catch (e) {
    print(e);
  }

  initializeDateFormatting('es_ES', null).then(
    (_) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<RouterCubit>(create: (context) => sl()),
          BlocProvider(
              create: (context) => sl<AuthBloc>()..add(CheckAuthStatus())),
          BlocProvider<PaymentPlansBloc>(
              create: (context) => sl<PaymentPlansBloc>()),
        ],
        child: const RockStarDataApp(),
      ),
    ),
  );
}
