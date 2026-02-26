import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Solo manejar estados finales, no intermedios
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is BusinessConfigRequired) {
          context.go('/business_omboarding');
        } else if (state is AuthUnauthenticated || state is AuthFailure) {
          context.go('/login');
        }
        // Dejar que AuthPage maneje AuthInitial y AuthLoading
      },
      child: BasePage(
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/pilotstar_logo_2.png',
                width: 289,
                height: 106,
                fit: BoxFit.contain,
              ),
            ),
            // 2. El Indicador de carga posicionado en la parte inferior
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 50.0), // Ajusta el margen inferior a tu gusto
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
