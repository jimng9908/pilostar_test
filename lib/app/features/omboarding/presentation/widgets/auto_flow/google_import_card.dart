import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class GoogleImportCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController _urlController = TextEditingController();

  GoogleImportCard({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título principal
                Text(
                  'Acelera tu registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1A171C),
                    fontSize: 22,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtítulo
                Text(
                  'Conecta tu negocio usando tu URL de Google Maps para importar automáticamente tu información.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4A5565),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Campo de URL
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'URL de Google Maps',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: 'https://maps.google.com/...',
                    hintStyle:
                        TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: FormValidator.validateUrl,
                ),
                const SizedBox(height: 16),

                // Botón Conectar
                BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
                  builder: (context, state) {
                    return ValueListenableBuilder(
                      valueListenable: _urlController,
                      builder: (context, value, child) {
                        final isNotEmpty = value.text.isNotEmpty;
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isNotEmpty
                                ? () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<BusinessOnboardingBloc>()
                                          .add(
                                            ImportGoogleData(
                                                placeUrl: _urlController.text),
                                          );
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              disabledBackgroundColor: Colors.grey.shade300,
                              disabledForegroundColor:
                                  Colors.white.withValues(alpha: 0.5),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                            ),
                            child: Text(
                              'Conectar',
                              style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Sección "¿Qué datos se importarán?"
                _buildInfoBox(
                  title: '¿Qué datos se importarán?',
                  content: Column(
                    children: [
                      _buildBenefitItem('Nombre y categoría del negocio'),
                      _buildBenefitItem('Dirección y ubicación'),
                      _buildBenefitItem('Valoración y número de reseñas'),
                      _buildBenefitItem('Horarios de apertura'),
                      _buildBenefitItem('Datos de contacto'),
                      _buildBenefitItem('Terraza disponible'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sección "¿Cómo encontrar tu URL?"
                _buildInfoBox(
                  title: '¿Cómo encontrar tu URL de Google Maps?',
                  showIcon: true,
                  content: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildHelpStep('Busca tu negocio en Google Maps'),
                        _buildHelpStep('Haz clic en el nombre de tu negocio'),
                        _buildHelpStep(
                            'Copia la URL que aparece en la barra de direcciones'),
                        _buildHelpStep('Pega la URL en el campo de arriba'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Botón Rellenar manualmente
                TextButton(
                  onPressed: () {
                    context
                        .read<BusinessOnboardingBloc>()
                        .add(GoToManualEntry());
                  },
                  child: Text(
                    'Rellenar manualmente',
                    style: TextStyle(
                      color: const Color(0xFF540BA8) /* Brand-Primary-800 */,
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(
      {required String title, required Widget content, bool showIcon = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (showIcon) ...[
                Icon(Icons.open_in_new, size: 16, color: AppColor.primaryLight),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: AppColor.primaryLight,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: AppColor.black.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpStep(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: AppColor.black.withValues(alpha: 0.6),
          height: 1.4,
        ),
      ),
    );
  }
}
