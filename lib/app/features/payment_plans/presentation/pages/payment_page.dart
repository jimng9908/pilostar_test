import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentPlansBloc, PaymentPlansState>(
      listenWhen: (previous, current) =>
          previous.clientSecret != current.clientSecret ||
          previous.isPaymentError != current.isPaymentError ||
          previous.subscriptionStatus != current.subscriptionStatus,
      listener: (context, state) {
        // 1. Manejo de Stripe Payment Sheet
        if (state.useStripe &&
            state.clientSecret.isNotEmpty &&
            !state.isPaymentProcessing &&
            state.paymentStatus == null) {
          _displayPaymentSheet(
              context, state.clientSecret, state.paymentIntentId);
        }

        // 2. Manejo de Errores
        if (state.isPaymentError && state.errorMessage != null) {
          CustomNotification.show(
            context,
            title: 'Error',
            message: state.errorMessage!,
            type: NotificationType.error,
          );
        }

        // 3. Manejo de Éxito (Suscripción Activa)
        if (state.subscriptionStatus != null &&
            state.subscriptionStatus!.hasActivePlan) {

          CustomNotification.show(
            context,
            title: '¡Bienvenido!',
            message: 'Tu acceso ha sido activado con éxito.',
            type: NotificationType.success,
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.goNamed(RouteName.chatOmboarding);
            }
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              AppColor.primary.withValues(blue: 0.28, red: 0.15, green: 0.09),
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              height: kToolbarHeight * 0.7,
              child: Image.asset(
                'assets/images/pilotstar_logo_4.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        body: BlocBuilder<PaymentPlansBloc, PaymentPlansState>(
          builder: (context, state) {
            // Pantalla de carga inicial si no hay planes
            if (state.isLoading! &&
                (state.plans == null || state.plans!.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }

            // Si no hay planes y no está cargando, intentamos obtenerlos
            if (state.plans == null || state.plans!.isEmpty) {
              context.read<PaymentPlansBloc>().add(GetPlansEvent());
              return const Center(child: CircularProgressIndicator());
            }

            final plan = state.plans![state.currentIndex];

            final adaptedPlan = {
              'id': plan.id,
              'title': plan.name,
              'subtitle': plan.description,
              'price': plan.price,
              'features': [
                'Setup en menos de 5 minutos',
                'Integración TPV automática',
                'KPIs críticos en tiempo real',
                'Histórico de Datos de 2 años',
                'Conectores GA4 y reservas',
                'Alertas automáticas',
              ],
            };

            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    const PaymentPlansHeader(),
                    const SizedBox(height: 16),
                    PlanCard(
                      plan: adaptedPlan,
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),
                    _buildFooterText(),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      state.useStripe,
                      state.isPaymentProcessing,
                      plan.id,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Cancela en cualquier momento. Sin costes ocultos.',
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          fontSize: 12,
          color: Colors.grey[500],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, bool useStripe, bool isProcessing, int planId) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomButton(
          onPressed: isProcessing
              ? null
              : () {
                  if (useStripe) {
                    context
                        .read<PaymentPlansBloc>()
                        .add(CreatePaymentIntentEvent(planId));
                  } else {
                    context.read<PaymentPlansBloc>().add(StartFreeTrialEvent());
                  }
                },
          text: useStripe ? 'Pagar con Stripe' : 'Empieza prueba gratuita',
          textColor: AppColor.white,
          isLoading: isProcessing,
        ),
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
