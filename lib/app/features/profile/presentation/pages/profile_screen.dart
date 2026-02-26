import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';
import 'package:rockstardata_apk/app/features/profile/presentation/widgets/index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.goNamed(RouteName.login);
          }
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            overscroll: false,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileHeader(),
                const SizedBox(height: 10),

                // Sección MI NEGOCIO
                const ProfileSectionHeader(title: "MI NEGOCIO"),
                ProfileMenuItem(
                  icon: Icons.access_time,
                  iconColor: Colors.blue,
                  title: "Horario",
                  subtitle: "Días y horas de apertura",
                  onTap: () => context.goNamed(RouteName.schedule),
                ),
                _buildDivider(),
                ProfileMenuItem(
                  icon: Icons.restaurant,
                  iconColor: Colors.pink,
                  title: "Configuración del Local",
                  subtitle: "Mesas, comensales, terraza...",
                  onTap: () => context.goNamed(RouteName.venueConfig),
                ),
                _buildDivider(),
                ProfileMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: Colors.purple,
                  title: "Servicios",
                  subtitle: "Local, para llevar, delivery...",
                  onTap: () => context.goNamed(RouteName.services),
                ),
                _buildDivider(),
                ProfileMenuItem(
                  icon: Icons.track_changes,
                  iconColor: Colors.deepPurple,
                  title: "Objetivos y Metas",
                  subtitle: "Define y gestiona tus objetivos",
                  onTap: () => context.goNamed(RouteName.goals),
                ),

                // Sección CUENTA
                const ProfileSectionHeader(title: "CUENTA"),
                BlocBuilder<PaymentPlansBloc, PaymentPlansState>(
                  builder: (context, state) {
                    bool havePlan = false;
                    if (state.subscriptionStatus != null) {
                      final suscription = state.subscriptionStatus;
                      havePlan = suscription!.hasActivePlan &&
                          suscription.plan!.contains('Starter');
                    } else {
                      havePlan = false;
                    }
                    return ProfileMenuItem(
                      icon: Icons.credit_card,
                      iconColor: Colors.purple,
                      title: "Plan y Facturación",
                      subtitle: "Gestiona tu suscripción",
                      onTap: () {
                        if (havePlan) {
                          context.goNamed(RouteName.manageSubscription);
                        } else {
                          context.goNamed(RouteName.subscription);
                        }
                      },
                    );
                  },
                ),
                _buildDivider(),
                ProfileMenuItem(
                  icon: Icons.phone_android,
                  iconColor: Colors.teal,
                  title: "Fuentes de Datos",
                  subtitle: "AEMET, LastApp, CoverManager,",
                  onTap: () => context.goNamed(RouteName.dataSources),
                ),
                _buildDivider(),
                ProfileMenuItem(
                  icon: Icons.settings,
                  iconColor: Colors.pink,
                  title: "Configuración de Notificaciones",
                  subtitle: "Gestiona tus alertas y avisos",
                  onTap: () => context.goNamed(RouteName.notificationSettings),
                ),

                // Sección APLICACIÓN
                const ProfileSectionHeader(title: "APLICACIÓN"),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  iconColor: Colors.blue,
                  title: "Ayuda y Soporte",
                  subtitle: "Centro de ayuda y contacto",
                  onTap: () => context.goNamed(RouteName.helpSupport),
                ),
                _buildDivider(),
                ProfileMenuItem(
                  icon: Icons.description_outlined,
                  iconColor: Colors.grey,
                  title: "Términos y Privacidad",
                  subtitle: "Políticas legales",
                  onTap: () => context.goNamed(RouteName.privacyTerms),
                ),

                const SizedBox(height: 20),

                // Botón Cerrar Cuenta
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        onPressed: state is! AuthLoading
                            ? () {
                                context.read<AuthBloc>().add(LogoutRequested());
                              }
                            : null,
                        backgroundColor: const Color(0xFFD32F2F),
                        text: "Cerrar cuenta",
                        textColor: Colors.white,
                        isLoading: state is AuthLoading,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Version info
                Text(
                  "PilotStar v1.2.0 • Powered by RoockstarData",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.5,
      indent: 60,
      endIndent: 0,
      color: Color(0xFFEEEEEE),
    );
  }
}
