import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            bool isCancelled = false;
            if (state is ProfileLoaded) {
              isCancelled = state.hasPlanCancelled;
            }
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                // Banner Plan Started
                if (!isCancelled) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: const Color(0x19560BAD),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.65,
                          color: const Color(0x33560BAD),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.workspace_premium,
                            color: Color(0xFF6A1B9A)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Plan Started',
                                style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 1.47,
                                  letterSpacing: -0.60,
                                ),
                              ),
                              const Text(
                                'Tu plan se renovará automáticamente el 15 de febrero de 2026',
                                style: TextStyle(
                                  color: Color(0xCC560AAC),
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                  letterSpacing: -0.38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  _buildCancelledInfo(context)
                ],

                const SizedBox(height: 24),

                // Método de Pago
                Text(
                  'Método de Pago',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                    letterSpacing: -0.26,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.65,
                        color: const Color(0xFFE0E0E0),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/credit_card_icon.png'),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Visa •••• 4242',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Expira 12/2026',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text('Cambiar',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Historial de Facturas
                Text(
                  'Historial de Facturas',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                    letterSpacing: -0.26,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: List.generate(3, (index) => _buildInvoiceItem()),
                  ),
                ),
                const SizedBox(height: 24),

                // Sección Cancelar
                if (!isCancelled) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: ShapeDecoration(
                      color: const Color(0x0CCC3E59),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.65,
                          color: const Color(0x33CB3D58),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.error_outline,
                                color: Color(0xFFD8435A), size: 20),
                            SizedBox(width: 8),
                            Text(
                              '¿Necesitas cancelar tu suscripción?',
                              style: TextStyle(
                                color: Color(0xFFCC3E59),
                                fontSize: 17,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 1.47,
                                letterSpacing: -0.60,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Puedes cancelar en cualquier momento. Tu plan seguirá activo hasta el final del período de facturación.',
                              style: TextStyle(
                                color: Color(0xCCCB3D58),
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.40,
                                letterSpacing: -0.38,
                              ),
                            )),
                        const SizedBox(height: 8),
                        CustomButton(
                          text: 'Cancelar suscripción',
                          textColor: const Color(0xFFF2F2F2),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (ctx) => MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                  ),
                                ],
                                child: const CancelationFlowSheet(),
                              ),
                            );
                          },
                          backgroundColor: const Color(0xFFD8435A),
                        )
                      ],
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInvoiceItem() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.65,
            color: const Color(0xFFE0E0E0),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.credit_card, color: Colors.grey.shade400),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Factura',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.47,
                    letterSpacing: -0.60,
                  ),
                ),
                const Text(
                  '15/01/2026',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.47,
                    letterSpacing: -0.60,
                  ),
                ),
                Row(
                  spacing: 8,
                  children: [
                    Text(
                      'Pagada',
                      style: TextStyle(
                        color: AppColor.darkPink,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.47,
                        letterSpacing: -0.60,
                      ),
                    ),
                    const Text(
                      '• 45,00€',
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: -0.23,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.file_download_outlined, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  _buildCancelledInfo(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Container(
          width: double.infinity,
          height: 14.0.hp(context),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: const Color(0x19CC3E59),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.65,
                color: const Color(0x33CB3D58),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 13,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 24.99,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0.61,
                            child: Text(
                              'Plan Cancelado',
                              style: TextStyle(
                                color: const Color(0xFFCC3E59),
                                fontSize: 17,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 1.47,
                                letterSpacing: -0.60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        SizedBox(
                          width: 260,
                          child: Text(
                            'Tu plan finalizará el 15 de febrero de 2026. Después de esta fecha perderás acceso a todas las funciones.',
                            style: TextStyle(
                              color: const Color(0xCCCB3D58),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 24.0.hp(context),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: const Color(0x19560BAD),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.65,
                color: const Color(0x33560BAD),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            spacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 13,
                children: [
                  Icon(Icons.favorite_border_rounded,
                      color: AppColor.primary.withValues(alpha: 0.8)),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Cambiaste de opinión?',
                          style: TextStyle(
                            color: const Color(0xFF560BAD),
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.47,
                            letterSpacing: -0.60,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Puedes reactivar tu plan en cualquier momento antes del 15 de febrero de 2026. Recuperarás acceso inmediato a todas las funciones.',
                            style: TextStyle(
                              color: const Color(0xCC560AAC),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 50.0.wp(context),
                  child: CustomButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<ProfileBloc>(),
                            ),
                          ],
                          child: const RestartSubscription(),
                        ),
                      );
                    },
                    text: 'Reactivar Plan Started',
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
