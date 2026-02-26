import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/presentation/index.dart';
import 'package:rockstardata_apk/app/features/auth/presentation/blocs/auth_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _dashboardHeader(context),
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 10.0.hp(context)),
          child: const TimeTabsSelector(),
        ),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            final data = state.data;
            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: SingleChildScrollView(
                key: ValueKey(data.filterType),
                // Eliminamos padding vertical innecesario arriba porque ya lo dan los filtros
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                physics:
                    const ClampingScrollPhysics(), // Evita el rebote y los huecos blancos
                child: Column(
                  children: [
                    // 1. Tarjeta Principal
                    MainIncomeCard(
                      amount: data.mainAmount,
                      percentage: data.mainPercentage,
                      filterType: state.selectedFilter.label,
                      goal: data.mainGoal,
                    ),

                    const SizedBox(height: 20),

                    // 2. Grid de Métricas
                    MetricGrid(
                        metrics: data.metrics, filterType: data.filterType),

                    // 3. Sección de Detalle
                    if (data.chartData != null) ...[
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            "📊 ${state.selectedFilter.label} en Detalle",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                            ),
                          ),
                          DetailChartSection(
                            data: data.chartData!,
                          ),
                        ],
                      ),
                    ],

                    // 4. Sección Meteorológica (Solo visible en "Hoy")
                    if (state.selectedFilter == DashboardFilter.hoy) ...[
                      const SizedBox(height: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            "⛅ Datos Meteorológicos",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                            ),
                          ),
                          const WeatherSection(),
                        ],
                      ),
                    ],

                    const SizedBox(height: 25),

                    // 5. Sección de Objetivos
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          "🎯 Objetivos",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                        ObjectivesSection(objectives: data.objectives),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const DashboardShimmer(key: ValueKey('loading'));
        },
      ),
    );
  }
}

/// Header simple para mantener la limpieza del build principal
Widget _dashboardHeader(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 16, bottom: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            String userName = 'Usuario';
            if (authState is AuthAuthenticated) {
              final user = authState.user;
              if (user != null) {
                userName = user.name ?? user.email;
              } else if (authState is UserRegistered) {
                userName = authState.registerResponse!.firstName ?? 'Usuario';
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hola de nuevo,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                  ),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontSize: 20,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w400,
                    height: 1.30,
                  ),
                ),
              ],
            );
          },
        ),
        GestureDetector(
          onTap: () {
            context.pushNamed(RouteName.notifications);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none,
                color: Colors.black87, size: 22),
          ),
        ),
      ],
    ),
  );
}
