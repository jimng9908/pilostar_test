import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static void showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? subtitle,
    NotificationDetails? notificationDetails,
    String? payload,
  }) async {
    final FlutterLocalNotificationsPlugin notificationPlugin =
        FlutterLocalNotificationsPlugin();

    await notificationPlugin.show(
      id: id,
      title: title,
      body: body,
      payload: payload,
      notificationDetails: notificationDetails ??
          NotificationDetails(
            // Android: Estilo moderno similar a iOS
            android: AndroidNotificationDetails(
              'pilotstar_channel',
              'Pilotstar Notifications',
              channelDescription: 'Notificaciones importantes de Pilotstar',
              importance: Importance.max,
              priority: Priority.high,
              // Estilo visual iOS-like
              styleInformation: BigTextStyleInformation(
                body,
                htmlFormatBigText: true,
                contentTitle: title,
                htmlFormatContentTitle: true,
                summaryText: subtitle,
                htmlFormatSummaryText: true,
              ),
              // Colores y apariencia
              color: const Color(0xFF007AFF), // Azul característico de iOS
              colorized: true,
              enableLights: true,
              ledColor: const Color(0xFF007AFF),
              ledOnMs: 1000,
              ledOffMs: 500,
              // Sonido y vibración
              playSound: true,
              enableVibration: true,
              vibrationPattern: Int64List.fromList([0, 250, 250, 250]),
              // Comportamiento
              showWhen: true,
              autoCancel: true,
              ongoing: false,
              // Icono (asegúrate de tener @mipmap/ic_launcher en tu proyecto)
              icon: '@mipmap/ic_launcher',
              largeIcon:
                  const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
            ),
            // iOS: Configuración completa estilo nativo
            iOS: DarwinNotificationDetails(
              subtitle: subtitle,
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: 'default',
              badgeNumber: 1,
              threadIdentifier: 'pilotstar_notifications',
              // Configuración de interrupción (iOS 15+)
              interruptionLevel: InterruptionLevel.active,
            ),
          ),
    );
  }
}
