import 'dart:ui';
import 'package:flutter/material.dart';

enum NotificationType { success, error, info }

class CustomNotification {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
  }) {
    // Obtenemos el overlay y los datos de pantalla antes de crear la entrada
    final overlay = Overlay.of(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;

    final opacityNotifier = ValueNotifier<double>(0.0);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _IOSNotificationView(
        title: title,
        message: message,
        type: type,
        topPadding: topPadding,
        screenWidth: screenWidth,
        opacityListenable: opacityNotifier,
        onDismiss: () async {
          opacityNotifier.value = 0.0;
          await Future.delayed(const Duration(milliseconds: 300));
          if (entry.mounted) entry.remove();
        },
      ),
    );

    overlay.insert(entry);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (entry.mounted) opacityNotifier.value = 1.0;
    });

    Future.delayed(const Duration(seconds: 2), () async {
      if (entry.mounted && opacityNotifier.value == 1.0) {
        opacityNotifier.value = 0.0;
        await Future.delayed(const Duration(milliseconds: 500));
        if (entry.mounted) entry.remove();
      }
    });
  }
}

class _IOSNotificationView extends StatelessWidget {
  final String title;
  final String message;
  final NotificationType type;
  final double topPadding;
  final double screenWidth;
  final ValueNotifier<double> opacityListenable;
  final VoidCallback onDismiss;

  const _IOSNotificationView({
    required this.title,
    required this.message,
    required this.type,
    required this.topPadding,
    required this.screenWidth,
    required this.opacityListenable,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final style = _getStyle();

    // Importante: En Overlay debemos proveer Directionality y Material explícitamente
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder<double>(
        valueListenable: opacityListenable,
        builder: (context, opacity, child) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuart,
            top: opacity == 1.0 ? topPadding + 50 : -150,
            left: 12,
            right: 12,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: opacity,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta! < -7) onDismiss();
                },
                child: Material(
                  // El Material evita errores de renderizado de texto
                  color: Colors.transparent,
                  elevation: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                            width: 0.5,
                          ),
                        ),
                        child: _buildBody(style),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(Map<String, dynamic> style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: style['color'].withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(style['icon'], color: style['color'], size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "ahora",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getStyle() {
    switch (type) {
      case NotificationType.success:
        return {'color': Colors.green.shade600, 'icon': Icons.check};
      case NotificationType.error:
        return {'color': Colors.redAccent, 'icon': Icons.close};
      default:
        return {'color': Colors.blueAccent, 'icon': Icons.info_outline};
    }
  }
}
