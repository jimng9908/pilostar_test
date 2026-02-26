import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';
import 'package:intl/intl.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentPlansBloc, PaymentPlansState>(
      // Escuchamos cambios específicos para disparar acciones de una sola vez
      listenWhen: (previous, current) =>
          (previous.clientSecret != current.clientSecret &&
              current.clientSecret.isNotEmpty) ||
          (previous.subscriptionStatus != current.subscriptionStatus) ||
          (previous.isPaymentError != current.isPaymentError),
      listener: (context, state) {
        if (state.isPaymentError && state.errorMessage != null) {
          CustomNotification.show(context,
              title: 'Error',
              message: state.errorMessage!,
              type: NotificationType.error);
          return;
        }

        // 2. Stripe: Solo abrimos si el usuario REALMENTE presionó el botón de Stripe (useStripe es true)
        // y si acabamos de recibir un clientSecret nuevo (paymentStatus es null)
        if (state.useStripe &&
            state.clientSecret.isNotEmpty &&
            state.paymentStatus == null &&
            !state.isPaymentProcessing) {
          _displayPaymentSheet(
              context, state.clientSecret, state.paymentIntentId);
        }

        // 3. Éxito de suscripción (Trial o Stripe)
        if (state.subscriptionStatus != null &&
            state.subscriptionStatus!.hasActivePlan) {
          // Si viene de Stripe, verificamos que el pago haya sido exitoso antes de saltar
          // Si viene de Trial (useStripe es false), saltamos directamente
          if (!state.useStripe ||
              (state.useStripe && state.paymentStatus?.status == 'succeeded')) {
            CustomNotification.show(
              context,
              title: '¡Plan Activado!',
              message: 'Tu suscripción está lista.',
              type: NotificationType.success,
            );
            context.pushReplacementNamed(RouteName.manageSubscription);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        appBar: AppBar(
          backgroundColor: AppColor.white,
          surfaceTintColor: AppColor.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Plan y Facturación',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildInfoSuscriptionCard(context),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Método de pago',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPaymentMethodsSection(context),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'Cancela en cualquier momento. Sin costes ocultos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSuscriptionCard(BuildContext context) {
    final firstChargeDate = DateTime.now().add(const Duration(days: 15));
    final formattedDate =
        DateFormat("d 'de' MMMM 'de' y", 'es_ES').format(firstChargeDate);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.50, 0.00),
          end: Alignment(0.50, 1.00),
          colors: [Color(0xFF560BAD), Color(0xFF7F38A5)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 51,
                height: 51,
                decoration: ShapeDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Icon(Icons.workspace_premium, color: Colors.white),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '¡Activa tu Plan Started!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w500,
                        height: 1.30,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Te quedan 12 días de prueba gratuita. Activa tu plan ahora y asegura acceso continuo a todas las funciones.',
                      style: TextStyle(
                        color: Color(0xCCFFFEFE),
                        fontSize: 16,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: -0.32,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureRow('Sin interrupción del servicio'),
          _buildFeatureRow('Todos tus datos y configuraciones se mantienen'),
          _buildFeatureRow('Cancela cuando quieras'),
          const SizedBox(height: 16),
          BlocBuilder<PaymentPlansBloc, PaymentPlansState>(
            builder: (context, state) {
              // Si no hay planes cargados, disparamos la carga
              if (state.plans == null || state.plans!.isEmpty) {
                context.read<PaymentPlansBloc>().add(GetPlansEvent());
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }

              final plan = state.plans!.firstWhere(
                (p) => p.name == 'Starter' || p.name == 'Started',
                orElse: () => state.plans!.first,
              );

              return CustomButton(
                text: 'Activar Plan Started - ${plan.price}€/mes',
                textColor: AppColor.white,
                isLoading: state.isPaymentProcessing,
                onPressed: () {
                  if (state.useStripe) {
                    context
                        .read<PaymentPlansBloc>()
                        .add(CreatePaymentIntentEvent(plan.id));
                  } else {
                    // En esta pantalla solo permitimos activar mediante Stripe según tu lógica previa
                    CustomNotification.show(context,
                        title: "Error",
                        message: "Selecciona un método de pago válido",
                        type: NotificationType.info);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'El primer cobro será el $formattedDate',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xB2FFFEFE),
                fontSize: 12,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: Colors.white, size: 20),
          const SizedBox(width: 8.5),
          Expanded(
            child: Text(
              s,
              style: const TextStyle(
                color: Color(0xE5FFFEFE),
                fontSize: 16,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsSection(BuildContext context) {
    return BlocBuilder<PaymentPlansBloc, PaymentPlansState>(
      buildWhen: (previous, current) => previous.useStripe != current.useStripe,
      builder: (context, state) {
        final isStripeSelected = state.useStripe;
        return Container(
          width: double.infinity,
          height: 8.0.hp(context),
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.96,
              color: isStripeSelected ? AppColor.primary : Colors.grey.shade400,
            ),
          ),
          child: _buildPaymentOption(
            context,
            title: 'Tarjeta de crédito/débito',
            icon: Icons.credit_card,
            isSelected: isStripeSelected,
            onTap: () {
              context.read<PaymentPlansBloc>().add(ToggleStripePaymentEvent());
            },
          ),
        );
      },
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
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColor.primary : Colors.grey.shade400,
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
    );
  }

  Future<void> _displayPaymentSheet(
      BuildContext context, String clientSecret, String paymentIntentId) async {
    final stripeInstance = Stripe.instance;
    final PaymentSheetApplePay applePay = PaymentSheetApplePay(
      merchantCountryCode: 'ES',
      buttonType: PlatformButtonType.pay,
    );

    try {
      await stripeInstance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'PilotStar',
          customFlow: false,
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'ES',
            currencyCode: 'EUR',
            testEnv: true,
            label: 'PilotStar',
          ),
          applePay: Platform.isIOS ? applePay : null,
          appearance: PaymentSheetAppearance(
            shapes: const PaymentSheetShape(
              borderRadius: 12,
              borderWidth: 1.0,
            ),
            colors: PaymentSheetAppearanceColors(
              primary: AppColor.infoDark,
              background: AppColor.white,
              componentBackground: AppColor.white,
              componentBorder: AppColor.black,
              componentDivider: AppColor.black,
              primaryText: AppColor.primaryDark,
              secondaryText: AppColor.grey,
              placeholderText: AppColor.grey,
              componentText: AppColor.primaryDark,
              icon: AppColor.black,
              error: AppColor.red,
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: AppColor.purple,
                  text: AppColor.white,
                  border: AppColor.infoDark,
                  successBackgroundColor:
                      AppColor.infoDark.withValues(alpha: 0.5),
                  successTextColor: AppColor.white,
                ),
                dark: PaymentSheetPrimaryButtonThemeColors(
                  background: AppColor.purple,
                  text: AppColor.white,
                  border: AppColor.purple,
                  successBackgroundColor:
                      AppColor.purple.withValues(alpha: 0.5),
                  successTextColor: AppColor.white,
                ),
              ),
            ),
          ),
        ),
      );
      await stripeInstance.presentPaymentSheet();

      if (context.mounted) {
        context
            .read<PaymentPlansBloc>()
            .add(CheckPaymentSubscriptionStatusEvent(paymentIntentId));
        context.read<PaymentPlansBloc>().add(ToggleStripePaymentEvent());
      }
    } catch (e) {
      if (e is StripeException) {
        debugPrint('Error de Stripe: ${e.error.localizedMessage}');
      } else {
        debugPrint('Error general: $e');
      }
    }
  }
}
