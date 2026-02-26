import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Text(
              "Alertas",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.notifications_none, color: Colors.blueAccent, size: 20),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF8F9FA),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            const _SectionHeader(title: "HOY"),
            const SizedBox(height: 12),
            _NotificationCard(
              title: 'Coste de personal alto',
              description:
                  "Superas el límite recomendado. Optimiza tus turnos.",
              time: "10:30 AM",
              type: _NotificationType.alert,
            ),
            const SizedBox(height: 12),
            _NotificationCard(
              title: '☔ Probabilidad de lluvia ',
              description: 'Prevemos una caída de ventas en terraza del 30-50%',
              time: "09:15 AM",
              type: _NotificationType.info,
            ),
            const SizedBox(height: 24),
            const _SectionHeader(title: "AYER"),
            const SizedBox(height: 12),
            _NotificationCard(
              title: 'Equipo eficiente',
              description:
                  'Tu coste laboral ha bajado al 5%. Gestión de personal excelente.',
              time: "01:45 AM",
              type: _NotificationType.success,
            ),
            const SizedBox(height: 12),
            _NotificationCard(
              title: '📊 Patrón detectado',
              description: 'La lluvia redujo tus ventas un 20%.',
              time: "12:00 PM",
              type: _NotificationType.info,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 1.2,
      ),
    );
  }
}

enum _NotificationType { alert, info, success }

class _NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final _NotificationType type;

  const _NotificationCard({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color accentColor;
    Color bgColor;
    IconData icon;

    switch (type) {
      case _NotificationType.alert:
        accentColor = Colors.red;
        bgColor = const Color(0xFFFFEBEE);
        icon = Icons.warning_amber_rounded;
      case _NotificationType.info:
        accentColor = Colors.deepPurple;
        bgColor = Colors.deepPurple.withValues(alpha: 0.0);
        icon = Icons.info_outline;
      case _NotificationType.success:
        accentColor = Colors.green;
        bgColor = const Color(0xFFE8F5E9);
        icon = Icons.check_circle_outline;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 5,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: accentColor, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Color.lerp(accentColor, Colors.black, 0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            color: Color.lerp(accentColor, Colors.black, 0.4),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Color.lerp(accentColor, Colors.black, 0.5),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
