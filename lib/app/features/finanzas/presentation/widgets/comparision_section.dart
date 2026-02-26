import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';

class ComparisonSection extends StatelessWidget {
  final ComparisonData data;

  const ComparisonSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingresos vs Gastos',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.30,
                letterSpacing: -0.65,
              ),
            ),
            const SizedBox(height: 16),
            _buildBar(
                'Ingresos', data.ingresos, AppColor.darkPink, data.incomeGoal),
            const SizedBox(height: 24),
            _buildBar('Gastos', data.gastos, AppColor.purple, data.expenseGoal,
                isExpense: true),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String label, double value, Color colorIcon, double goal,
      {bool isExpense = false}) {
    final percentage = (value / goal * 100).toInt().clamp(0, 100);
    final progressColor =
        KpiColorMapper.getProgressBarColor(value, goal, isExpense: isExpense);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                    isExpense
                        ? Icons.analytics_outlined
                        : Icons.payments_outlined,
                    size: 16,
                    color: colorIcon),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.38,
                  ),
                ),
              ],
            ),
            Text(
              '$percentage%',
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
            end: (value / goal).clamp(0.0, 1.0),
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
                text: '${NumberFormat.decimalPattern('es_ES').format(value)} €',
              ),
              const TextSpan(
                text: '   /   ',
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: '${NumberFormat.decimalPattern('es_ES').format(goal)} €',
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
