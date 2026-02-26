import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UserRegistered && state.registerResponse != null) {
            debugPrint(
                'User registered successfully: ${state.registerResponse?.verificationCode}');
            context.goNamed(RouteName.verificationMail);
          } else if (state is UserRegistered && state.user != null) {
            context.goNamed(RouteName.businessOmboarding);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
