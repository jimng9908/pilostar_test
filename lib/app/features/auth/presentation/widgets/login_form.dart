import 'dart:io';

import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              width: 80.0.wp(context),
              height: 8.0.hp(context),
              child: Image.asset(
                'assets/images/pilotstar_logo_2.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shadowColor: AppColor.black.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Título
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Iniciar sesión',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF364153),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Email label
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dirección de correo electrónico',
                          style: TextStyle(
                            color: const Color(0xFF364153),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Correo electrónico',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFF490C7D)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: FormValidator.validateEmail,
                      ),
                      const SizedBox(height: 16),

                      // Password label
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Contraseña',
                          style: TextStyle(
                            color: const Color(0xFF364153),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      ValueListenableBuilder<bool>(
                        valueListenable: _obscurePasswordNotifier,
                        builder: (context, isPasswordObscured, child) {
                          return TextFormField(
                            controller: _passwordController,
                            obscureText: isPasswordObscured,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordObscured
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey.shade600,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _obscurePasswordNotifier.value =
                                      !isPasswordObscured;
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFF490C7D)),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: FormValidator.validatePassword,
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Botón de Iniciar Sesión con gradiente
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      LoginRequested(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            text: 'Iniciar Sesión',
                            textColor: AppColor.white,
                            isLoading: state is AuthLoading,
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Link para crear cuenta
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿Todavía no tienes cuenta? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontFamily: 'Inter',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push('/register');
                            },
                            child: Text(
                              'Crear una cuenta',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF490C7D),
                                fontFamily: 'Inter',
                              ),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Divider con texto centrado (minúsculas)
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'o seguir con',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Botones sociales container
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Platform.isIOS
                              ? SocialButton(
                                  iconPath: 'assets/icons/apple_icon.png',
                                  label: 'Apple',
                                  onTap: () {},
                                )
                              : SocialButton(
                                  iconPath: 'assets/icons/google_icon.png',
                                  label: 'Google',
                                  onTap: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(GoogleLoginRequested());
                                  },
                                ),
                          const SizedBox(width: 20),
                          SocialButton(
                            iconPath: 'assets/icons/microsoft_Icon.png',
                            label: 'Microsoft',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
