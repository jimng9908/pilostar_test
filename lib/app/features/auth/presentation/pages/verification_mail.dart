import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class VerificationMailPage extends StatelessWidget {
  const VerificationMailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.outfit(
        fontSize: 22,
        color: const Color(0xFF1D1D1F),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColor.primary, width: 2),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColor.primary.withValues(
            blue: 0.28, red: 0.15, green: 0.09), // Morado profundo del diseño
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.goNamed(RouteName.register),
        ),
        title: SizedBox(
          height: kToolbarHeight * 0.7,
          child: Image.asset(
            'assets/images/pilotstar_logo_4.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserRegistered && state.user != null) {
            CustomNotification.show(
              context,
              title: 'Éxito',
              message: 'Cuenta activada exitosamente',
              type: NotificationType.success,
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              if (!context.mounted) return;
              context.go('/business_omboarding');
            });
          }
          if (state is AuthFailure) {
            CustomNotification.show(
              context,
              title: 'Error',
              message: state.message,
              type: NotificationType.error,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is! UserRegistered) {
              return const SizedBox.shrink();
            }

            final registerResponse = state.registerResponse;

            return Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Column(
                children: [
                  Text(
                    'Verifique su código',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w500,
                      height: 1.30,
                      color: const Color(0xFF1A171C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Ingresa el código de acceso que acabas de recibir en tu dirección de correo electrónico ${FormValidator.maskEmail(registerResponse?.email ?? '')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF495565),
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    onCompleted: (pin) {
                      context.read<AuthBloc>().add(
                            VerifyCodeRequested(
                              email: registerResponse?.email ?? '',
                              code: pin,
                            ),
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
