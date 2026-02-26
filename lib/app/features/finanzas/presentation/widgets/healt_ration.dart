import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';

class HealthRatiosSection extends StatelessWidget {
  final List<RatioData> ratios;

  const HealthRatiosSection({super.key, required this.ratios});

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
            const Text(
              'Ratios de Salud',
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
            ...ratios.map((ratio) {
              final percentageDisplay = ratio.percentage.toInt().clamp(0, 100);
              final progressValue = (ratio.percentage / 100).clamp(0.0, 1.0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                                ratio.label == 'Personal'
                                    ? Icons.people_outline
                                    : Icons.restaurant_menu,
                                size: 16,
                                color: ratio.label == 'Personal'
                                    ? AppColor.green
                                    : AppColor.purple),
                            const SizedBox(width: 8),
                            Text(
                              ratio.label,
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
                            color: ratio.label == 'Personal'
                                ? KpiColorMapper.getProgressPersonalColor(
                                    ratio.percentage / 100)
                                : KpiColorMapper.getProgressMateriaColor(
                                    ratio.percentage / 100),
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
                                '${NumberFormat.decimalPattern('es_ES').format(ratio.currentAmount)} €',
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
                                '${NumberFormat.decimalPattern('es_ES').format(ratio.targetAmount)} €',
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
            }),
          ],
        ),
      ),
    );
  }
}
