// Dart/Flutter
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:flutter/material.dart';

// Paquetes externos
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Core

void configEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 10)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColor.white
    ..backgroundColor = AppColor.mainColor.withAlpha(230)
    ..indicatorColor = AppColor.white
    ..textColor = AppColor.white
    ..maskColor = AppColor.black.withAlpha(128)
    ..userInteractions = true
    ..dismissOnTap = true
    ..maskType = EasyLoadingMaskType.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..customAnimation = CustomEasyLoadingAnimation();
}

class CustomEasyLoadingAnimation extends EasyLoadingAnimation {
  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: ScaleTransition(
        scale: controller.drive(CurveTween(curve: Curves.easeInOutBack)),
        child: child,
      ),
    );
  }
}

// Clase helper para manejar diferentes estilos
class EasyLoadingHelper {
  // Configuración para loading normal
  static void showLoading({String? status}) {
    EasyLoading.instance
      ..backgroundColor = AppColor.mainColor.withAlpha(230)
      ..indicatorColor = AppColor.white
      ..textColor = AppColor.white
      ..indicatorType = EasyLoadingIndicatorType.ring;

    EasyLoading.show(status: status ?? 'Cargando...');
  }

  // Configuración para success
  static void showSuccess(String message) {
    EasyLoading.instance
      ..backgroundColor = AppColor.green.withAlpha(230)
      ..indicatorColor = AppColor.white
      ..indicatorSize = 45.0
      ..textColor = AppColor.white
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..displayDuration = const Duration(seconds: 2);

    EasyLoading.showSuccess(message);
  }

  static void showToastSuccess(
    String message, {
    EasyLoadingToastPosition? position,
    Duration? duration,
  }) {
    EasyLoading.instance
      ..backgroundColor = AppColor.green.withAlpha(230)
      ..textColor = AppColor.white
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..displayDuration = duration ?? const Duration(seconds: 2);

    EasyLoading.showToast(message);
  }

  // Configuración para error
  static void showError(String message) {
    EasyLoading.instance
      ..backgroundColor = AppColor.red.withAlpha(230)
      ..indicatorColor = AppColor.white
      ..indicatorSize = 45.0
      ..textColor = AppColor.white
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..displayDuration = const Duration(seconds: 3);

    EasyLoading.showError(message);
  }

  static void showToastError(
    String message, {
    EasyLoadingToastPosition? position,
    Duration? duration,
  }) {
    EasyLoading.instance
      ..backgroundColor = AppColor.red.withAlpha(230)
      ..textColor = AppColor.white
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..displayDuration = duration ?? const Duration(seconds: 3);

    EasyLoading.showToast(message);
  }

  // Configuración para info
  static void showInfo(String message) {
    EasyLoading.instance
      ..backgroundColor = AppColor.blue.withAlpha(230)
      ..indicatorColor = AppColor.white
      ..indicatorSize = 45.0
      ..textColor = AppColor.white
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..displayDuration = const Duration(seconds: 5);

    EasyLoading.showInfo(message);
  }

  static void showToastInfo(
    String message, {
    EasyLoadingToastPosition? position,
    Duration? duration,
  }) {
    EasyLoading.instance
      ..backgroundColor = AppColor.blue.withAlpha(230)
      ..textColor = AppColor.white
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..displayDuration = duration ?? const Duration(seconds: 3);

    EasyLoading.showToast(message);
  }

  static void showToastLila(
    String message, {
    EasyLoadingToastPosition? position,
    Duration? duration,
  }) {
    EasyLoading.instance
      ..backgroundColor = AppColor.primary
      ..textColor = AppColor.white
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..displayDuration = duration ?? const Duration(seconds: 3);

    EasyLoading.showToast(message);
  }

  // Configuración para toast
  static void showToast(
    String message, {
    EasyLoadingToastPosition? position,
    Duration? duration,
  }) {
    EasyLoading.instance
      ..backgroundColor = AppColor.black.withAlpha(200)
      ..textColor = AppColor.white
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..displayDuration = duration ?? const Duration(seconds: 3);

    EasyLoading.showToast(message);
  }

  // Configuración para warning
  static void showWarning(String message) {
    EasyLoading.instance
      ..backgroundColor = Colors.yellow.withAlpha(230)
      ..indicatorColor = AppColor.white
      ..indicatorSize = 45.0
      ..textColor = AppColor.white
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..displayDuration = const Duration(seconds: 3);

    EasyLoading.showInfo(message);
  }

  static void showToastWarning(
    String message, {
    EasyLoadingToastPosition? position,
    Duration? duration,
  }) {
    EasyLoading.instance
      ..backgroundColor = AppColor.yellow.withAlpha(230)
      ..textColor = AppColor.black
      ..toastPosition = position ?? EasyLoadingToastPosition.bottom
      ..displayDuration = duration ?? const Duration(seconds: 3);

    EasyLoading.showToast(message);
  }

  // Configuración para progress
  static void showProgress(double value, {String? status}) {
    EasyLoading.instance
      ..backgroundColor = AppColor.mainColor.withAlpha(230)
      ..progressColor = AppColor.white
      ..textColor = AppColor.white
      ..indicatorColor = AppColor.white;

    EasyLoading.showProgress(value, status: status);
  }

  // Dismiss
  static Future<void> dismiss() async {
    await EasyLoading.dismiss();
  }
}
