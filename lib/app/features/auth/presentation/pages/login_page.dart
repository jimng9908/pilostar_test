import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/home');
          }
          if (state is BusinessConfigRequired) {
            context.go('/business_omboarding');
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
