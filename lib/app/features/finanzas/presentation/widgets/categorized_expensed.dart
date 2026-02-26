import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';

class CategorizedExpensesSection extends StatelessWidget {
  final List<CategorizedExpense> expenses;
  final bool isTrimestre;

  const CategorizedExpensesSection(
      {super.key, required this.expenses, required this.isTrimestre});

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
            Text(
              'Gastos del ${isTrimestre ? 'Trimestre' : 'Año'}',
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
            ...expenses.map(
              (expense) {
                final progressColor =
                    KpiColorMapper.getProgressGenericExpenseColor(
                        expense.percentage / 100);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(expense.label,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Text(
                                '${NumberFormat.decimalPattern('es_ES').format(expense.amount)}€',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(${expense.percentage.toStringAsFixed(0)}%)',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInOut,
                        tween: Tween<double>(
                          begin: 0,
                          end: (expense.percentage / 100).clamp(0.0, 1.0),
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
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
