import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';

class EBITDASection extends StatelessWidget {
  final EBITDAData data;
  final bool isTrimestre;

  const EBITDASection(
      {super.key, required this.data, required this.isTrimestre});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Beneficio Real (EBITDA)',
                  style: TextStyle(
                    color: const Color(0xFF6B6B6B),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.47,
                    letterSpacing: -0.38,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: data.growthPercentage > 0
                            ? AppColor.green.withValues(alpha: 0.2)
                            : AppColor.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                              data.growthPercentage > 0
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: data.growthPercentage > 0
                                  ? Colors.green
                                  : Colors.red,
                              size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${NumberFormat.decimalPattern('es_ES').format(data.growthPercentage)}%',
                            style: TextStyle(
                                color: data.growthPercentage > 0
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'vs. ${isTrimestre ? 'trimestre anterior' : 'año anterior'}',
                      style: TextStyle(
                        color: const Color(0xFF6B6B6B),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.47,
                        letterSpacing: -0.38,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${NumberFormat.decimalPattern('es_ES').format(data.value)} €',
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.30,
                letterSpacing: -0.12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${data.profitabilityPercentage.toStringAsFixed(0)}% de rentabilidad',
              style: TextStyle(
                color: const Color(0xFF6B6B6B),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.47,
                letterSpacing: -0.60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
