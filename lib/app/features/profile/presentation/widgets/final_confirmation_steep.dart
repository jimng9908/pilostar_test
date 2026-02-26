import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class FinalConfirmationStep extends StatelessWidget {
  const FinalConfirmationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        bool isCanceling = false;
        if (state is ProfileLoaded) {
          isCanceling = state.isSaving;
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
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 17,
                children: [
                  Container(
                    width: 59.49,
                    height: 59.49,
                    padding: const EdgeInsets.only(right: 0.01),
                    decoration: ShapeDecoration(
                      color: const Color(0x19CC3E59),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Icon(Icons.warning_amber_outlined,
                        color: Colors.red, size: 24),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.50,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 28.59,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0.65,
                                  child: Text(
                                    'Confirmar Cancelación',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 1.30,
                                      letterSpacing: -0.59,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 51,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0.61,
                                  child: SizedBox(
                                    width: 219,
                                    child: Text(
                                      'Tu suscripción se cancelará y perderás acceso a:',
                                      style: TextStyle(
                                        color: const Color(0xFF6B6B6B),
                                        fontSize: 17,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.50,
                                        letterSpacing: -0.60,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Cuadro de pérdida de beneficios
              Container(
                padding: const EdgeInsets.all(16),
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
                  children: [
                    _buildLossItem('Fuentes de datos integradas'),
                    _buildLossItem('KPIs ilimitados y análisis IA'),
                    _buildLossItem('Histórico de datos de 12 meses'),
                    _buildLossItem('Chat AI y soporte prioritario'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    'Tu plan seguirá activo hasta el',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF6B6B6B),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      letterSpacing: -0.23,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 315,
                        child: Text(
                          '24 de febrero de 2026',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF6B6B6B),
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                            letterSpacing: -0.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 345.11,
                    child: Text(
                      '. Después de esta fecha, ya no podrás acceder a estos servicios.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF6B6B6B),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.23,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Sí, Cancelar',
                textColor: AppColor.white,
                onPressed: !isCanceling
                    ? () =>
                        context.read<ProfileBloc>().add(SubmitCancellation())
                    : null,
                backgroundColor: const Color(0xFFD8435A),
                isLoading: isCanceling,
              ),
              const SizedBox(height: 8),
              CustomButton(
                text: 'Mantener Plan',
                textColor: AppColor.white,
                backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(ResetCancellationFlow());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLossItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        const Icon(Icons.close, color: Colors.red, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Color(0xFFD8435A))),
      ]),
    );
  }
}
