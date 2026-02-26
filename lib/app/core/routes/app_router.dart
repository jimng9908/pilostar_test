import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:rockstardata_apk/app/features/chat_bot/index.dart';
import 'package:rockstardata_apk/app/features/home/index.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/features/home/presentation/pages/notification_page.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

import 'package:rockstardata_apk/app/injection.dart';

class RouterCubit extends Cubit<GoRouter> {
  RouterCubit() : super(_appRouter);
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorChatKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellChat');
final _shellNavigatorFinanceKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFinance');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

final GoRouter _appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    //SplashPage
    GoRoute(
      path: '/',
      name: RouteName.splash,
      builder: (context, state) => const SplashPage(),
    ),
    //LoginPage
    GoRoute(
      path: '/login',
      name: RouteName.login,
      builder: (context, state) => const LoginPage(),
    ),
    //RegisterPage
    GoRoute(
      path: '/register',
      name: RouteName.register,
      builder: (context, state) {
        return RegisterPage();
      },
    ),
    //VerificationMailPage
    GoRoute(
      path: '/verification_mail',
      name: RouteName.verificationMail,
      builder: (context, state) {
        return VerificationMailPage();
      },
    ),
    //ImportDataPage
    GoRoute(
      path: '/business_omboarding',
      name: RouteName.businessOmboarding,
      builder: (context, state) => BusinessMethodPage(),
      routes: [
        GoRoute(
          path: 'google_import',
          name: RouteName.googleImport,
          builder: (context, state) => GoogleImportPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/plans',
      name: RouteName.plans,
      builder: (context, state) => const PaymentPage(),
    ),
    GoRoute(
      path: '/chat_ombording',
      name: RouteName.chatOmboarding,
      builder: (context, state) => const ChatBotOmbordingPage(),
    ),
    GoRoute(
      path: '/notification_request_permission',
      name: RouteName.notificationRequestPermission,
      builder: (context, state) => const NotificationRequestPermission(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Aquí devolvemos nuestro Scaffold que contiene el NavBar
        return CustomNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Primera Pestaña: Home
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            ShellRoute(
              builder: (context, state, child) => BlocProvider.value(
                value: sl<DashboardBloc>(),
                child: child,
              ),
              routes: [
                GoRoute(
                  path: '/home',
                  name: RouteName.home,
                  builder: (context, state) => const DashboardPage(),
                  routes: [
                    GoRoute(
                      path: 'weather',
                      name: RouteName.weather,
                      builder: (context, state) => const WeatherDetailsPage(),
                    ),
                    GoRoute(
                      path: 'notifications',
                      name: RouteName.notifications,
                      builder: (context, state) => const NotificationPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Segunda Pestaña: Chat
        StatefulShellBranch(
          navigatorKey: _shellNavigatorChatKey,
          routes: [
            ShellRoute(
              builder: (context, state, child) => BlocProvider.value(
                value: sl<ChatBotBloc>(),
                child: child,
              ),
              routes: [
                GoRoute(
                  path: '/chat_bot',
                  name: RouteName.chatBot,
                  builder: (context, state) => const ChatBotPage(),
                ),
              ],
            ),
          ],
        ),
        // Tercera Pestaña: Finanzas
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFinanceKey,
          routes: [
            GoRoute(
              path: '/finanzas',
              name: RouteName.finance,
              builder: (context, state) => const FinanzasScreen(),
            ),
          ],
        ),
        // Cuarta Pestaña: Perfil
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            ShellRoute(
              builder: (context, state, child) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: sl<ProfileBloc>(),
                  ),
                  BlocProvider.value(
                    value: sl<ScheduleBloc>(),
                  ),
                ],
                child: child,
              ),
              routes: [
                GoRoute(
                  path: '/profile',
                  name: RouteName.profile,
                  builder: (context, state) => const ProfileScreen(),
                  routes: [
                    GoRoute(
                      path: 'edit_profile',
                      name: RouteName.editProfile,
                      builder: (context, state) => const EditProfileScreen(),
                    ),
                    GoRoute(
                      path: 'help_support',
                      name: RouteName.helpSupport,
                      builder: (context, state) => const HelpSupportScreen(),
                    ),
                    GoRoute(
                      path: 'privacy_terms',
                      name: RouteName.privacyTerms,
                      builder: (context, state) => const PrivacyTermsScreen(),
                    ),
                    GoRoute(
                      path: 'manage_subscription',
                      name: RouteName.manageSubscription,
                      builder: (context, state) => const BillingScreen(),
                    ),
                    GoRoute(
                      path: 'subscription',
                      name: RouteName.subscription,
                      builder: (context, state) => const SubscriptionScreen(),
                    ),
                    GoRoute(
                      path: 'data_sources',
                      name: RouteName.dataSources,
                      builder: (context, state) => const DataSourcesScreen(),
                      routes: [
                        GoRoute(
                          path: 'config_kpis',
                          name: RouteName.configKpis,
                          builder: (context, state) {
                            final dataSource = state.extra as ProfileDataSource;
                            return ConfigKpiScreen(datasource: dataSource);
                          },
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'schedule',
                      name: RouteName.schedule,
                      builder: (context, state) {
                        final profileState = sl<ProfileBloc>().state;
                        final scheduleBloc = sl<ScheduleBloc>();
                        if (profileState is ProfileLoaded &&
                            !scheduleBloc.state.isInitialized) {
                          scheduleBloc.add(
                            InitializeScheduleEvent(profileState.schedule.days),
                          );
                        }
                        return const ScheduleScreen();
                      },
                    ),
                    GoRoute(
                      path: 'notifications',
                      name: RouteName.notificationSettings,
                      builder: (context, state) => const NotificationsScreen(),
                    ),
                    GoRoute(
                      path: 'venue_config',
                      name: RouteName.venueConfig,
                      builder: (context, state) => const VenueConfigScreen(),
                    ),
                    GoRoute(
                      path: 'services',
                      name: RouteName.services,
                      builder: (context, state) => const ServicesScreen(),
                    ),
                    GoRoute(
                      path: 'goals',
                      name: RouteName.goals,
                      builder: (context, state) => const GoalsScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    final paymentState = context.read<PaymentPlansBloc>().state;
    final location = state.uri.path;

    // Solo aplicar control de suscripción si el usuario está autenticado
    if (authState is! AuthAuthenticated) return null;

    // Rutas donde no exigir plan activo (login, registro, onboarding, planes)
    const allowedWithoutPlan = [
      '/',
      '/login',
      '/register',
      '/verification_mail',
      '/business_omboarding',
      '/plans',
      '/chat_ombording',
      '/notification_request_permission',
      '/profile',
    ];
    final isAllowed = allowedWithoutPlan
        .any((path) => location == path || location.startsWith('$path/'));
    if (isAllowed) return null;

    // Si ya sabemos que no tiene plan activo, redirigir a planes
    if (paymentState.subscriptionStatus != null &&
        !paymentState.subscriptionStatus!.hasActivePlan) {
      return '/home';
    }

    return null;
  },
);
