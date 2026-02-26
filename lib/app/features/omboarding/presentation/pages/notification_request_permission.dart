import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationRequestPermission extends StatelessWidget {
  const NotificationRequestPermission({super.key});

  Future<void> _requestNotificationPermission(BuildContext context) async {
    final status = await Permission.notification.request();

    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permisos requeridos'),
            content: const Text(
                'Las notificaciones están desactivadas permanentemente en la configuración de tu dispositivo. Por favor, actívalas manualmente para recibir actualizaciones importantes.'),
            actions: [
              CustomButton(
                onPressed: () => Navigator.pop(context),
                text: 'Cancelar',
                textColor: AppColor.primary,
                backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 8),
              CustomButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                text: 'Configuración',
                backgroundColor: AppColor.primary,
                textColor: AppColor.white,
              ),
            ],
          ),
        );
      }
    } else {
      if (context.mounted) {
        _handleNavigation(context);
      }
    }
  }

  void _handleNavigation(BuildContext context) {
    context.goNamed(RouteName.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 48),
                    child: Column(
                      children: [
                        // Avatar / Icon Section
                        _buildAvatar(context),
                        const SizedBox(height: 32),
                        const Text(
                          'Déjanos ayudarte con tus objetivos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Recibe notificaciones sobre tu progreso y mantente al día con las métricas que importan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF6B6B6B),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Benefits List
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _PermissionItem(
                          icon: Icons.track_changes,
                          iconColor: const Color(0xFF00C950),
                          title: 'Progreso de objetivos',
                          description:
                              'Te avisaremos cuando estés cerca de alcanzar tus metas',
                        ),
                        const SizedBox(height: 16),
                        _PermissionItem(
                          icon: Icons.notifications_active_outlined,
                          iconColor: const Color(0xFF9A19DF),
                          title: 'Alertas importantes',
                          description:
                              'Recibe avisos sobre cambios en tus métricas',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Actions Section
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 35.0.wp(context),
            height: 15.0.hp(context),
            decoration: BoxDecoration(
              color: AppColor.primaryLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.primaryLight.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              size: 56,
              color: Color(0xFF560BAD),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.grey.withValues(alpha: 0.1),
        border: Border(
          top: BorderSide(color: AppColor.grey.withValues(alpha: 0.3)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            text: 'Activar notificaciones',
            onPressed: () => _requestNotificationPermission(context),
            textColor: Colors.white,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Ahora no',
            onPressed: () => _handleNavigation(context),
            textColor: AppColor.primaryLight,
            backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Puedes cambiar tus preferencias de notificaciones en cualquier momento desde mi perfil',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6B6B6B),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissionItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _PermissionItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontSize: 15,
                    height: 1.4,
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
