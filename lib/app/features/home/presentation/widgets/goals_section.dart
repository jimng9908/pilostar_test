import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/index.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/utils/kpi_mappers.dart';

class ObjectivesSection extends StatelessWidget {
  final List<ObjectiveEntity> objectives;
  const ObjectivesSection({super.key, required this.objectives});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...objectives.map(
          (obj) {
            final color =
                KpiColorMapper.getProgressGoalsColor(obj.current / obj.target);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.track_changes_outlined,
                                size: 18, color: color),
                            const SizedBox(width: 8),
                            Text(obj.title,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.trending_up, size: 14, color: color),
                            const SizedBox(width: 4),
                            Text(
                                "${NumberFormat.decimalPattern('es_ES').format((obj.current * 100 / obj.target).toInt())}%",
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                            '${NumberFormat.decimalPattern('es_ES').format(obj.current)} ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                              letterSpacing: -0.43,
                            )),
                        Text(
                            "${obj.unit} / ${NumberFormat.decimalPattern('es_ES').format(obj.target)} ${obj.unit}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                              letterSpacing: -0.08,
                            )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: obj.current / obj.target,
                        minHeight: 6,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation(
                            KpiColorMapper.getProgressGoalsColor(
                                obj.current / obj.target)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
