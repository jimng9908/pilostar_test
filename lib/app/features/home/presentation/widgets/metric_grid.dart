import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/index.dart';

class MetricGrid extends StatelessWidget {
  final List<MetricEntity> metrics;
  final String filterType;

  const MetricGrid({
    super.key,
    required this.metrics,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("${1.0.hp(context) / 10.5}");
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0.hp(context) / 9.8,
      ),
      itemBuilder: (context, index) {
        final metric = metrics[index];

        return MetricCard(
          title: metric.title,
          value: metric.value,
          trend: metric.trend,
          isPositive: metric.isPositive,
          kpi: metric.kpi,
          goalProgress: metric.goalProgress,
          subtitle: metric.subtitle,
          kpiType: metric.kpi,
          filterType: filterType,
        );
      },
    );
  }
}
