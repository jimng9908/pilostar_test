import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.plan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentPlansBloc, PaymentPlansState>(
      builder: (context, state) {
        final useStripe = state.useStripe;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TrialBadge(),
                const SizedBox(height: 12),
                _buildPlanIcon(context),
                Text(
                  plan['title'],
                  style: GoogleFonts.outfit(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1D1D1F),
                  ),
                ),
                Text(
                  'El Esencial',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                _buildPriceSection(plan['price']),
                const SizedBox(height: 32),
                _buildDescriptionSection(),
                const SizedBox(height: 32),
                const Divider(indent: 24, endIndent: 24, height: 1),
                const SizedBox(height: 24),
                _buildFeaturesSection(plan['features']),
                const SizedBox(height: 48),
                _buildPaymentMethodsSection(context, useStripe),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlanIcon(BuildContext context) {
    return Container(
      width: 63.99,
      height: 63.99,
      padding: const EdgeInsets.only(right: 0.01),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.00),
          end: Alignment(1.00, 1.00),
          colors: [const Color(0xFF495565), const Color(0xFF354152)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Center(
        child: Text(
          '📊',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF1A171C),
            fontSize: 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.20,
            letterSpacing: 0.40,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceSection(dynamic price) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          spacing: 5,
          children: [
            Text(
              NumberFormat.decimalPattern()
                  .format(double.parse(price.toString())),
              style: GoogleFonts.outfit(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                color: const Color(0xFF1D1D1F),
              ),
            ),
            Text(
              '€',
              style: TextStyle(
                color: const Color(0xFF697282),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: -0.15,
              ),
            ),
          ],
        ),
        Text(
          'local / mes',
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            'Ideal para negocios de barrio o emprendedores que inician',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: const Color(0xFF424245),
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Todo lo básico que necesitas para empezar a tomar el control',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(List<dynamic> features) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: features
            .map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: AppColor.success, size: 18),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature.toString(),
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: const Color(0xFF424245),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context, bool useStripe) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Método de pago',
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D1D1F),
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentOption(
            context,
            title: 'Tarjeta de crédito/débito',
            icon: Icons.credit_card,
            isSelected: useStripe,
            onTap: () {
              context
                  .read<PaymentPlansBloc>()
                  .add(ToggleStripePaymentEvent());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.primaryLight : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColor.primaryLight : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryLight,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Icon(icon, color: Colors.grey[700], size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D1D1F),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
