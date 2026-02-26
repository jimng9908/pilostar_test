import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Centro de Ayuda",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "¿Necesitas ayuda inmediata?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Contact Cards
              _buildContactCard(
                icon: Icons.chat_bubble_outline,
                title: "Chat en vivo",
                subtitle: "Disponible 24/7",
                onTap: () {
                  debugPrint("Chat en vivo");
                },
              ),
              const SizedBox(height: 12),
              _buildContactCard(
                icon: Icons.email_outlined,
                title: "Email",
                subtitle: "soporte@pilotstar.com",
                onTap: () {
                  debugPrint("Email");
                },
              ),
              const SizedBox(height: 12),
              _buildContactCard(
                icon: Icons.phone_outlined,
                title: "Teléfono",
                subtitle: "+34 900 123 456",
                onTap: () {
                  debugPrint("Teléfono");
                },
              ),

              const SizedBox(height: 40),

              const Text(
                "Preguntas Frecuentes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // FAQ Section
              _buildFAQItem(
                context,
                "¿Cómo conecto mis fuentes de datos?",
                "Ve a Configuración > Fuentes de datos y selecciona el sistema que deseas conectar. Sigue las instrucciones de autorización para cada fuente.",
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                context,
                "¿Con qué frecuencia se actualizan las métricas?",
                "Las métricas se actualizan en tiempo real cuando hay nuevos datos disponibles. La mayoría de las fuentes sincronizan cada hora automáticamente.",
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                context,
                "¿Cómo configuro alertas personalizadas?",
                "Ve a Configuración > Notificaciones para configurar alertas personalizadas basadas en umbrales específicos de tus métricas.",
              ),
              const SizedBox(height: 12),
              _buildFAQItem(
                context,
                "¿Mis datos están seguros?",
                "Sí, utilizamos encriptación de extremo a extremo y cumplimos con todas las normativas de protección de datos GDPR. Tus datos nunca se comparten con terceros.",
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF7B1FA2), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String response) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          iconColor: Colors.black54,
          collapsedIconColor: Colors.black54,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                response,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
