import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ImportFromGoogle extends StatelessWidget {
  const ImportFromGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        if (state is BusinessOnboardingLoaded &&
            state.step == OnboardingStep.googleReview) {
          final business = state.businessInformations.first;
          return Column(
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          // Título principal
                          Text(
                            'Datos importados',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w500,
                              height: 1.30,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Subtítulo
                          Text(
                            'Hemos importado exitosamente la información de tu perfil de Google Maps. Revisa que todo sea correcto.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A5565),
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),

                          // Lista de datos
                          _buildDataCard(
                            icon: Icons.location_on_outlined,
                            label: 'Dirección',
                            value: business.formattedAddress ?? 'No disponible',
                          ),
                          _buildDataCard(
                            icon: Icons.local_offer_outlined,
                            label: 'Categoría',
                            value: business.categories.isNotEmpty
                                ? business.categories.join(', ')
                                : 'No disponible',
                          ),
                          _buildDataCard(
                            icon: Icons.star_outline,
                            label: 'Valoración',
                            child: Row(
                              children: [
                                Text(
                                  '${business.rating ?? 0.0}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildRatingStars(business.rating ?? 0.0),
                              ],
                            ),
                          ),
                          _buildDataCard(
                            icon: Icons.phone_outlined,
                            label: 'Teléfono',
                            value: business.phone ?? 'No disponible',
                          ),
                          _buildDataCard(
                            icon: Icons.access_time,
                            label: 'Horario',
                            value: business.openingHours.isNotEmpty
                                ? _formatOpeningHours(business.openingHours)
                                : 'No disponible',
                          ),
                          _buildDataCard(
                            icon: Icons.star_outline,
                            label: 'Total de reseñas',
                            value: '${business.userRatingsTotal ?? 0}',
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Botón Siguiente
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomButton(
                    text: 'Siguiente',
                    onPressed: () {
                      context
                          .read<BusinessOnboardingBloc>()
                          .add(ConfirmGoogleData());
                    },
                    textColor: AppColor.white,
                  ),
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildDataCard({
    required IconData icon,
    required String label,
    String? value,
    Widget? child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Icon(icon, color: AppColor.primaryLight, size: 24),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF6B6B6B),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.47,
                    letterSpacing: -0.38,
                  ),
                ),
                if (child != null)
                  child
                else
                  Text(
                    value ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Color(0xFFFFC107), size: 18);
        } else if (index < rating) {
          return const Icon(Icons.star_half,
              color: Color(0xFFFFC107), size: 18);
        } else {
          return Icon(Icons.star_outline,
              color: Colors.grey.shade300, size: 18);
        }
      }),
    );
  }

  String _formatOpeningHours(List<OpeningHour> hours) {
    if (hours.isEmpty) return 'No disponible';
    // Simplified for now: show the first day or a summary
    // Typically: "Lun-Dom: 12:00 - 00:00"
    // Let's check if all hours are the same or just join them
    final first = hours.first;
    final last = hours.length > 1 ? hours.last : null;

    if (last != null && first.hours == last.hours && hours.length >= 7) {
      return 'Lun-Dom: ${first.hours}';
    }

    return '${first.day}: ${first.hours}';
  }
}
