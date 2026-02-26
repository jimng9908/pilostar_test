import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/config/app_color.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ServicesSelection extends StatelessWidget {
  const ServicesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        final List<String> selectedServices =
            (state is BusinessOnboardingLoaded) ? state.selectedServices : [];

        final bool localSelected = selectedServices.contains("Local");
        final bool deliverySelected = selectedServices.contains("Delivery");
        final bool takeawaySelected = selectedServices.contains("Takeaway");

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Servicios",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF1A171C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Selecciona los servicios que ofreces",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4A5565),
                          ),
                        ),
                        const SizedBox(height: 32),
                        _ServiceCard(
                          title: "Solo en Local",
                          subtitle: "Consumo en el establecimiento",
                          icon: Icons.food_bank_outlined,
                          gradientColors: [
                            const Color(0xFFBA9BDD),
                            const Color(0xFFBA9BDD)
                          ],
                          isSelected: localSelected,
                          onTap: () =>
                              context.read<BusinessOnboardingBloc>().add(
                                    const ToggleService("Local"),
                                  ),
                        ),
                        const SizedBox(height: 16),
                        _ServiceCard(
                          title: "Delivery",
                          subtitle: "Servicio de entrega a domicilio",
                          icon: Icons.motorcycle_outlined,
                          gradientColors: [
                            const Color(0xFFAC46FF),
                            const Color(0xFFF6329A)
                          ],
                          isSelected: deliverySelected,
                          onTap: () =>
                              context.read<BusinessOnboardingBloc>().add(
                                    const ToggleService("Delivery"),
                                  ),
                        ),
                        const SizedBox(height: 16),
                        _ServiceCard(
                          title: "Takeaway",
                          subtitle: "Comida para llevar",
                          icon: Icons.shopping_bag_outlined,
                          gradientColors: [
                            const Color(0xFF2B7FFF),
                            const Color(0xFF00B8DA)
                          ],
                          isSelected: takeawaySelected,
                          onTap: () =>
                              context.read<BusinessOnboardingBloc>().add(
                                    const ToggleService("Takeaway"),
                                  ),
                        ),
                        const SizedBox(height: 20),
                        const InfoBox(
                          text:
                              "Puedes modificar estos servicios más tardes desde la configuración",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                bottom: true,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      CustomButton(
                        text: "Siguiente",
                        textColor: AppColor.white,
                        onPressed: selectedServices.isNotEmpty
                            ? () {
                                context.read<BusinessOnboardingBloc>().add(
                                    SubmitServices(services: selectedServices));
                              }
                            : null,
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        text: "Atrás",
                        textColor: AppColor.purple,
                        backgroundColor:
                            AppColor.greyDark.withValues(alpha: 0.3),
                        onPressed: () {
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(BackToPrevious());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColor.primaryLight : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.only(right: 0.01),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, 0.00),
                  end: Alignment(1.00, 1.00),
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColor.black, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
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
}
