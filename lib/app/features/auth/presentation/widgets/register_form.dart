import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RegisterForm({super.key});

  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirmPasswordNotifier =
      ValueNotifier(true);
  final ValueNotifier<bool> agreeToTerms = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final currentState = context.watch<AuthBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                width: 80.0.wp(context),
                height: 8.0.hp(context),
                child: Image.asset(
                  'assets/images/pilotstar_logo_2.png',
                ),
              ),
              const SizedBox(height: 20),
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
                            'Crear una cuenta',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF364153),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Nombre label
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nombre y apellidos',
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
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 14),
                          decoration: _inputDecoration(
                              hint: 'Introduce nombre y apellidos'),
                          validator: FormValidator.validateFullName,
                        ),
                        const SizedBox(height: 10),

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
                          decoration: _inputDecoration(
                              hint: 'Introduce correo electrónico'),
                          validator: FormValidator.validateEmail,
                        ),
                        const SizedBox(height: 10),

                        // Password label
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Crear una contraseña',
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
                                decoration: _inputDecoration(
                                  hint: 'Crea una contraseña',
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
                                ),
                                validator: FormValidator.validatePassword,
                              );
                            }),
                        const SizedBox(height: 10),

                        // Confirm Password label
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Confirma tu contraseña',
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
                            valueListenable: _obscureConfirmPasswordNotifier,
                            builder: (context, isPasswordObscured, child) {
                              return TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: isPasswordObscured,
                                style: const TextStyle(fontSize: 14),
                                decoration: _inputDecoration(
                                  hint: 'Repite tu contraseña',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordObscured
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      _obscureConfirmPasswordNotifier.value =
                                          !isPasswordObscured;
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  FormValidator.validatePassword(value);
                                  if (value != _passwordController.text) {
                                    return 'Las contraseñas no coinciden';
                                  }
                                  return null;
                                },
                              );
                            }),
                        const SizedBox(height: 20),

                        ValueListenableBuilder<bool>(
                          valueListenable: agreeToTerms,
                          builder: (context, isChecked, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    agreeToTerms.value = value ?? false;
                                  },
                                  activeColor: AppColor.primary,
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Acepto los ',
                                  style: TextStyle(
                                    fontSize: 10.0.sp(context),
                                    fontFamily: 'Inter',
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final accepted =
                                        await _showTermsDialog(context);
                                    agreeToTerms.value = accepted ?? false;
                                  },
                                  child: Text(
                                    'términos y condiciones',
                                    style: TextStyle(
                                      fontSize: 10.0.sp(context),
                                      color: AppColor.primary,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        // Botón de Crear Cuenta con gradiente
                        CustomButton(
                          onPressed: () {
                            if (!agreeToTerms.value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 2,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                      'Debes aceptar los términos y condiciones'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor:
                                      AppColor.warning.withValues(alpha: 0.85),
                                ),
                              );
                            } else if (_formKey.currentState!.validate()) {
                              final namesMap = mapperName(_nameController.text);
                              context.read<AuthBloc>().add(RegisterRequested(
                                    name: namesMap['nombres'] ?? '',
                                    lastName: namesMap['apellidos'] ?? '',
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    phoneNumber: '',
                                  ));
                            }
                          },
                          text: 'Crear cuenta',
                          isLoading: currentState is AuthLoading,
                          backgroundColor: AppColor.primary,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 20),
                        // Link para iniciar sesión
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '¿Ya tienes una cuenta? ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                fontFamily: 'Inter',
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Text(
                                'Iniciar sesión',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF490C7D),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        // Divider con texto centrado
                        Row(
                          children: [
                            Expanded(
                                child: Divider(color: Colors.grey.shade300)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'o seguir con',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            Expanded(
                                child: Divider(color: Colors.grey.shade300)),
                          ],
                        ),

                        // Botones sociales
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
                                          .add(GoogleRegisterRequested());
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

                        const SizedBox(height: 10),

                        // Footer con terms y privacy
                        Center(
                          child: Column(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  const Text(
                                    'By clicking continue ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Terms of Service',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    ' and ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      suffixIcon: suffixIcon,
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
        borderSide: const BorderSide(color: Color(0xFF490C7D)),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Future<bool?> _showTermsDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        int activeTab = 0; // 0: Términos, 1: Privacidad
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header con título y botón cerrar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 14.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Términos y Condiciones',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            icon:
                                Icon(Icons.close, color: Colors.grey.shade600),
                          )
                        ],
                      ),
                    ),

                    // Tabs
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => activeTab = 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: activeTab == 0
                                      ? Colors.grey.shade100
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text('Términos',
                                      style: TextStyle(
                                          color: activeTab == 0
                                              ? AppColor.black
                                              : Colors.grey.shade600)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => activeTab = 1),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: activeTab == 1
                                      ? Colors.grey.shade100
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text('Privacidad',
                                      style: TextStyle(
                                          color: activeTab == 1
                                              ? AppColor.black
                                              : Colors.grey.shade600)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Contenido
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SingleChildScrollView(
                          child: activeTab == 0
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    const Text(
                                      '1. Aceptación de términos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'Al usar RockstarData, aceptas estos términos y condiciones.'),
                                    const SizedBox(height: 12),
                                    const Text(
                                      '2. Uso del servicio',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'RockstarData es una plataforma de análisis de datos para restaurantes y locales de hostelería.'),
                                    const SizedBox(height: 12),
                                    const Text(
                                      '3. Protección de datos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'Todos tus datos están encriptados y protegidos según la normativa GDPR.'),
                                    const SizedBox(height: 12),
                                    const Text(
                                      '4. Responsabilidades',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'El usuario es responsable de la veracidad de los datos proporcionados.'),
                                    const SizedBox(height: 12),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Política de Privacidad',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'En RockstarData protegemos tu privacidad y la de tu negocio.'),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Datos recopilados',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'Recopilamos únicamente los datos necesarios para el funcionamiento del servicio.'),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Uso de datos',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'Tus datos solo se usan para generar insights y análisis de tu negocio.'),
                                    const SizedBox(height: 12),
                                    const Text('Compartir información'),
                                    const SizedBox(height: 6),
                                    const Text(
                                        'Nunca compartimos tus datos con terceros sin tu consentimiento explícito.'),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.0.hp(context)),
                    // Acciones
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                foregroundColor: AppColor.white,
                              ),
                              child: const Text('Acepto los términos'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.white,
                                side: BorderSide(color: AppColor.primary),
                              ),
                              child: Text(
                                'Cancelar',
                                style: TextStyle(color: AppColor.primary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
