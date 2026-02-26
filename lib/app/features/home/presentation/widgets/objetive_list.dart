import 'package:flutter/material.dart';

class ObjectivesList extends StatelessWidget {
  const ObjectivesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🎯 Objetivos",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _objectiveItem(
            "Ventas mensuales", "86.420,00 €", "90.000,00", 0.96, Colors.green),
        const SizedBox(height: 12),
        _objectiveItem("Clientes mensuales", "1.200 clientes", "1.500", 0.80,
            Colors.purple),
        const SizedBox(height: 12),
        _objectiveItem("Ticket medio", "47,50 €", "50,00", 0.95, Colors.green),
      ],
    );
  }

  Widget _objectiveItem(String title, String current, String target,
      double progress, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              Text("${(progress * 100).toInt()}%",
                  style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(current,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(" / $target",
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}
