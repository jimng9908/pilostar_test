import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class FetchingGoogleData extends StatelessWidget {
  const FetchingGoogleData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        final double progress = (state is BusinessOnboardingLoading)
            ? (state.progress ?? 0.0)
            : 0.0;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    // Título
                    Text(
                      'Importando datos',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Subtítulo
                    Text(
                      'Estamos importando la información de tu enlace de Google Maps. Esto tomará solo unos momentos.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5565),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Indicador de Progreso Circular con Porcentaje Animado
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: progress),
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) {
                        final int animatedPercentage = (value * 100).toInt();
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: CircularProgressIndicator(
                                value: value,
                                strokeWidth: 8,
                                backgroundColor:
                                    AppColor.grey.withValues(alpha: 0.3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.primaryLight,
                                ),
                              ),
                            ),
                            Text(
                              '$animatedPercentage%',
                              style: TextStyle(
                                color: Colors.black /* Brand-Black */,
                                fontSize: 22,
                                fontFamily: 'SF Pro',
                                fontWeight: FontWeight.w500,
                                height: 1.30,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 48),

                    // Card "Fuentes de datos"
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fuentes de datos',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey.shade400,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Google Maps',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryLight
                                        .withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Info box azul claro
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFBBDEFB),
                        ),
                      ),
                      child: Text(
                        'Este proceso puede tardar entre 30 segundos y 2 minutos',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade800,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
