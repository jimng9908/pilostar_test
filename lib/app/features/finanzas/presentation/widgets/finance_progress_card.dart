import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';

class FinanceProgressItem {
  final String label;
  final IconData icon;
  final Color iconColor;
  final double icomme;
  final double goals;

  const FinanceProgressItem({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.icomme,
    required this.goals,
  });
}

class FinanceProgressCard extends StatelessWidget {
  final String title;
  final List<FinanceProgressItem> items;

  const FinanceProgressCard({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.30,
                letterSpacing: -0.65,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => _buildProgressItem(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem(FinanceProgressItem item) {
    // Avoid division by zero
    final progressValue =
        item.goals > 0 ? (item.icomme / item.goals).clamp(0.0, 1.0) : 0.0;
    final percentageDisplay = (progressValue * 100).toInt();

    final progressColor = KpiColorMapper.getProgressGoalsColor(progressValue);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(item.icon, size: 16, color: item.iconColor),
                  const SizedBox(width: 8),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.38,
                    ),
                  ),
                ],
              ),
              Text(
                '$percentageDisplay%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: progressValue,
            ),
            builder: (context, animatedValue, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: animatedValue,
                  backgroundColor: Colors.grey[200],
                  color: progressColor,
                  minHeight: 8,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text:
                      '${NumberFormat.decimalPattern('es_ES').format(item.icomme)} €',
                ),
                const TextSpan(
                  text: '   /   ',
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      '${NumberFormat.decimalPattern('es_ES').format(item.goals)} €',
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
