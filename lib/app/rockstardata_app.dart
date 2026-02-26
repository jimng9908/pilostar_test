import 'package:rockstardata_apk/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class RockStarDataApp extends StatelessWidget {
  const RockStarDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', 'ES'),
        Locale('es', 'MX'),
        Locale('es', 'AR'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: true,
      title: 'ROCK STAR',
      theme: _buildTheme(),
      routerConfig: context.read<RouterCubit>().state,
      builder: (context, child) {
        // 1. Primero aplicamos el ajuste de MediaQuery (textScaleFactor)
        final mediaQueryAdjustedChild = MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );

        // 2. Luego aplicamos la inicialización de EasyLoading
        return EasyLoading.init()(context, mediaQueryAdjustedChild);
      },
    );
  }

  // Tema Claro Personalizado
  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      primaryColorLight: AppColor.primaryLight,
      primaryColorDark: AppColor.primaryDark,
      colorScheme: ColorScheme.light(
        primary: AppColor.primary,
        primaryContainer: AppColor.primaryLight,
        secondary: AppColor.backgroundLight,
        secondaryContainer: AppColor.backgroundDark,
        surface: AppColor.white,
        surfaceBright: AppColor.backgroundLight,
        error: AppColor.error,
        onPrimary: AppColor.white,
        onSecondary: AppColor.textPrimary,
        onSurface: AppColor.textPrimary,
        onSurfaceVariant: AppColor.textPrimary,
        onError: AppColor.white,
      ),
      scaffoldBackgroundColor: AppColor.backgroundLight,
      appBarTheme: AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color: AppColor.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColor.cardBg,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: AppColor.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: AppColor.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: AppColor.textPrimary),
        bodyMedium: TextStyle(color: AppColor.textSecondary),
        bodySmall: TextStyle(color: AppColor.textTertiary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.white,
      ),
      dividerTheme: DividerThemeData(
        color: AppColor.border,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
