import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';

class WeatherHeader extends StatelessWidget {
  const WeatherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-2.00, 0.00),
          end: Alignment(0.00, 2.00),
          colors: [
            const Color(0xFF8148C2) /* Brand-Primary-600 */,
            const Color(0xFF3C0879) /* Brand-Primary-900 */
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.74,
            color: const Color(0xFFE0E0E0),
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Previsión AEMET",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Desglose por franjas horarias",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const DaySelector(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DaySelector extends StatelessWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final selectedDay =
            state is DashboardLoaded ? state.selectedWeatherDay : 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            DayTab(
              label: "Hoy",
              date: "15 de Enero",
              isSelected: selectedDay == 0,
              onTap: () =>
                  context.read<DashboardBloc>().add(ChangeWeatherDay(0)),
            ),
            DayTab(
              label: "Mañana",
              date: "16 de Enero",
              isSelected: selectedDay == 1,
              onTap: () =>
                  context.read<DashboardBloc>().add(ChangeWeatherDay(1)),
            ),
            DayTab(
              label: "Pasado",
              date: "17 de Enero",
              isSelected: selectedDay == 2,
              onTap: () =>
                  context.read<DashboardBloc>().add(ChangeWeatherDay(2)),
            ),
          ],
        );
      },
    );
  }
}

class DayTab extends StatelessWidget {
  final String label;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const DayTab({
    super.key,
    required this.label,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 27.0.wp(context),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.white : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF4A148C) : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.0.sp(context),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              date,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF4A148C).withValues(alpha: 0.7)
                    : Colors.white70,
                fontSize: 9.0.sp(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
