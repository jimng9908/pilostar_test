import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String period;
  final String time;
  final int temp;
  final int st;
  final String condition;
  final IconData icon;
  final Color color;
  final String precipitation;
  final String humidity;
  final String wind;

  const ForecastCard({
    super.key,
    required this.period,
    required this.time,
    required this.temp,
    required this.st,
    required this.condition,
    required this.icon,
    required this.color,
    required this.precipitation,
    required this.humidity,
    required this.wind,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 23),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(period,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3436))),
                      Text(time,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("$temp°",
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3436))),
                      Text("ST: $st°",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  Icon(icon, color: color, size: 40),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(condition,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: WeatherInfoItem(
                      icon: Icons.umbrella_outlined,
                      label: "Precipitación",
                      value: precipitation)),
              const SizedBox(width: 12),
              Expanded(
                  child: WeatherInfoItem(
                      icon: Icons.water_drop_outlined,
                      label: "Humedad",
                      value: humidity)),
            ],
          ),
          const SizedBox(height: 12),
          WeatherInfoItem(
            icon: Icons.air,
            label: "Viento",
            value: wind,
          ),
        ],
      ),
    );
  }
}

class WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436))),
        ],
      ),
    );
  }
}
