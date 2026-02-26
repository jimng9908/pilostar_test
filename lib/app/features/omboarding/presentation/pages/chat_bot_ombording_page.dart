import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ChatBotOmbordingPage extends StatelessWidget {
  const ChatBotOmbordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColor.primary,
        ),
        child: Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF3C0879),
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                        child: Column(
                          children: [
                            // Bot Avatar
                            SafeArea(
                              top: true,
                              child: Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: AppColor.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Icon(Icons.smart_toy_outlined,
                                    size: 48, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Tu Asistente IA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF2F1F4),
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Tu compañero inteligente para gestionar tu negocio de forma más eficiente',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF2F1F4),
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Feature Cards
                            const _FeatureCard(
                              icon: Icons.access_time,
                              title: 'Asistencia 24/7',
                              description:
                                  'Pregunta lo que necesites en cualquier momento',
                            ),
                            const SizedBox(height: 16),
                            const _FeatureCard(
                              icon: Icons.auto_awesome_outlined,
                              title: 'Respuestas inteligentes',
                              description:
                                  'Análisis contextuales basados en tus datos',
                            ),
                            const SizedBox(height: 16),
                            const _FeatureCard(
                              icon: Icons.bolt_outlined,
                              title: 'Acciones rápidas',
                              description:
                                  'Configura y gestiona tu negocio con comandos',
                            ),
                          ],
                        ),
                      ),
                      // Questions Section
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: AppColor.white.withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pregunta cosas como:',
                                style: TextStyle(
                                  color: Color(0xFFF2F1F4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 24),
                              const _ExampleQuestion(
                                  text: '¿Cómo van las ventas esta semana?'),
                              const SizedBox(height: 8),
                              const _ExampleQuestion(
                                  text: '¿Qué productos se venden más?'),
                              const SizedBox(height: 8),
                              const _ExampleQuestion(
                                  text: '¿Cómo configuro las notificaciones?'),
                              const SizedBox(height: 8),
                              const _ExampleQuestion(
                                  text: '¿Qué mejoras me recomiendas?'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom Actions
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                bottom: true,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        onPressed: () {
                          context.goNamed(RouteName.chatBot);
                        },
                        text: 'Hablar con el asistente',
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        onPressed: () async {
                          final permissionStatus =
                              await Permission.notification.status;
                          if (!permissionStatus.isGranted && context.mounted) {
                            context.goNamed(
                                RouteName.notificationRequestPermission);
                          } else if (context.mounted) {
                            context.goNamed(RouteName.home);
                          }
                        },
                        text: 'Ir a mis datos',
                        backgroundColor:
                            AppColor.greyDark.withValues(alpha: 0.3),
                        textColor: AppColor.primaryLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFF2F1F4),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFFF2F1F4),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleQuestion extends StatelessWidget {
  final String text;

  const _ExampleQuestion({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '"$text"',
        style: const TextStyle(
          color: Color(0xFFF2F1F4),
          fontSize: 14,
        ),
      ),
    );
  }
}
