import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class OfferStep extends StatelessWidget {
  const OfferStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        int? selectedOfferId;
        if (state is ProfileLoaded) {
          selectedOfferId = state.selectedOfferId;
        }
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('¡Espera! Tenemos una oferta para ti',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              // Icono Corazón
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.favorite_border,
                    color: Colors.deepPurple, size: 40),
              ),
              const SizedBox(height: 20),
              const Text(
                'Valoramos tu confianza. Antes de que te vayas, nos gustaría ofrecerte:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6B6B6B),
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: -0.43,
                ),
              ),
              const SizedBox(height: 24),

              // Card de Descuento (La de color morado)
              _buildOfferCard(
                context: context,
                offerId: 1,
                title: '20% de descuento',
                subtitle: 'Ahorra 15,80€/mes durante 3 meses',
                icon: Icons.attach_money,
                isSelected: selectedOfferId == 1,
              ),
              const SizedBox(height: 12),
              _buildOfferCard(
                context: context,
                offerId: 2,
                title: 'Pausar suscripción',
                subtitle: 'Congela tu plan por 1 mes',
                icon: Icons.pause_outlined,
                isSelected: selectedOfferId == 2,
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: () =>
                      context.read<ProfileBloc>().add(NextCancellationStep()),
                  backgroundColor: const Color(0xFFD8435A),
                  text: 'No, gracias. Quiero cancelar',
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOfferCard({
    required BuildContext context,
    required int offerId,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => context.read<ProfileBloc>()..add(SelectOffer(offerId)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.deepPurple : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? const Color(0xFFF9F7FF) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
                width: 51,
                height: 51,
                decoration: ShapeDecoration(
                  color: isSelected
                      ? const Color(0x33560BAD)
                      : Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Icon(icon,
                    color: isSelected ? Colors.deepPurple : Colors.grey)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: isSelected ? Colors.deepPurple : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : null)),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.38,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
