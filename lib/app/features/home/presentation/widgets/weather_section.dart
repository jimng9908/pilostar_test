import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/index.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.wb_sunny_outlined,
                          color: Colors.pinkAccent, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Próximos 3 días",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(RouteName.weather);
                    },
                    child: SizedBox(
                      width: 75,
                      child: Text(
                        'Ver detalle',
                        style: TextStyle(
                          color: const Color(0xFF560BAD),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  children: [
                    _buildWeatherCard(context, "Hoy", "15 Ene", "18°", "12°",
                        "21°", "10%", true),
                    const SizedBox(width: 12),
                    _buildWeatherCard(context, "Mañana", "16 Ene", "16°", "11°",
                        "19°", "30%", false),
                    const SizedBox(width: 12),
                    _buildWeatherCard(context, "Jueves", "17 Ene", "17°", "10°",
                        "20°", "5%", false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherCard(BuildContext context, String day, String date,
      String temp, String min, String max, String rain, bool isToday) {
    return GestureDetector(
      onTap: () {
        int index = 0;
        if (day.toLowerCase().contains('mañana')) {
          index = 1;
        } else if (day.toLowerCase().contains('jueves')) {
          index = 2;
        }
        context.read<DashboardBloc>().add(ChangeWeatherDay(index));
        context.pushNamed(RouteName.weather);
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        width: 35.0.wp(context),
        height: 19.0.hp(context),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, 0.00),
            end: Alignment(0.50, 1.00),
            colors: [Colors.white, const Color(0xFFF4F4F4)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.74,
              color: const Color(0xFFE0E0E0),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
                Icon(
                  isToday ? Icons.wb_sunny_outlined : Icons.cloud_outlined,
                  color: isToday ? Colors.pinkAccent : Colors.greenAccent,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              temp,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.arrow_downward, size: 10, color: Colors.grey),
                Text(min,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_upward, size: 10, color: Colors.grey),
                Text(max,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.water_drop_outlined,
                    size: 12, color: Colors.blue),
                const SizedBox(width: 4),
                Text(rain,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const HIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
