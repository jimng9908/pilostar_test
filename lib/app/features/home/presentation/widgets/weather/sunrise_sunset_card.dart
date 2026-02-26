import 'package:flutter/material.dart';

class SunriseSunsetCard extends StatelessWidget {
  const SunriseSunsetCard({super.key});

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
      child: Row(
        children: [
          Expanded(
            child: SunInfoRow(
              icon: Icons.light_mode,
              label: "Amanecer",
              time: "08:42",
              color: Colors.pink[400]!,
            ),
          ),
          Container(height: 40, width: 1, color: Colors.grey[200]),
          Expanded(
            child: SunInfoRow(
              icon: Icons.wb_twilight,
              label: "Atardecer",
              time: "18:15",
              color: Colors.deepPurple[400]!,
            ),
          ),
        ],
      ),
    );
  }
}

class SunInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final Color color;

  const SunInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            Text(
              time,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436)),
            ),
          ],
        ),
      ],
    );
  }
}
