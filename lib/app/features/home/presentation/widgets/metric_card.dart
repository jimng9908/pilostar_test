import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/utils/index.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/index.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final num value;
  final String trend;
  final bool isPositive;
  final KpiType kpi;
  final double? goalProgress;
  final String? subtitle;
  final KpiType kpiType;
  final String filterType;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.kpi,
    this.goalProgress,
    this.subtitle,
    required this.kpiType,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF0F0F0), // Gris más suave que el anterior
          ),
          borderRadius: BorderRadius.circular(16), // Bordes más redondeados
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconContainer(),
              Flexible(child: _buildTrendBadge(filterType)),
            ],
          ),
          const SizedBox(height: 10),
          // Valor principal con símbolo de Euro
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "${NumberFormat.decimalPattern('es_ES').format(value)} ${getSymbol(kpiType)}",
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 22,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ),
          // Título de la métrica
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF616161),
              fontSize: 16,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w500,
            ),
          ),
          if (goalProgress != null) ...[
            const SizedBox(height: 5),
            _buildGoalIndicator(),
          ],
        ],
      ),
    );
  }

  Widget _buildIconContainer() {
    return Icon(
      KpiIconMapper.getIcon(kpi),
      size: 18,
      color: const Color(0xFF673AB7),
    );
  }

  Widget _buildTrendBadge(String filterType) {
    final Color greenColor = const Color(0xFF00A36C);
    final Color bgColor =
        isPositive ? const Color(0xFFE8F7F0) : const Color(0xFFFFEBEE);
    final Color contentColor = isPositive ? greenColor : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius:
                BorderRadius.circular(20), // Estilo píldora de la imagen 2
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                size: 16,
                color: contentColor,
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: contentColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          MapperPreviousDate.getVsText(filterType),
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF9E9E9E),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalIndicator() {
    // Color naranja de la imagen 2: #FFB300
    final Color barColor = KpiColorMapper.getProgressGoalsColor(goalProgress!);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.track_changes, size: 12, color: barColor),
                const SizedBox(width: 6),
                const Text(
                  "Objetivo",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              "${(goalProgress! * 100).toInt()}%",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: barColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: goalProgress,
            minHeight: 6,
            backgroundColor: const Color(0xFFEEEEEE),
            valueColor: AlwaysStoppedAnimation(barColor),
          ),
        ),
      ],
    );
  }
}

String getSymbol(KpiType kpiType) {
  switch (kpiType) {
    case KpiType.googleRating:
    case KpiType.noShows:
    case KpiType.bookings:
      return '';
    case KpiType.occupancy:
    case KpiType.personal:
    case KpiType.material:
      return '%';
    case KpiType.productivity:
    case KpiType.averageTicket:
    case KpiType.totalRevenue:
      return '€';
    default:
      return '€';
  }
}
