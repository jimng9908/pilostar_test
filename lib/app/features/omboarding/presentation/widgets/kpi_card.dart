import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class KpiCard extends StatelessWidget {
  final KpiEntity kpi;
  final bool isSelected;
  final String category;
  final VoidCallback onTap;

  const KpiCard({
    super.key,
    required this.kpi,
    required this.isSelected,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? _getCategoryColor(category).withValues(alpha: 0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? _getCategoryColor(category)
                    : AppColor.grey.withValues(alpha: 0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                // Icon Placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getKpiIcon(category),
                    color: _getCategoryColor(category),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            kpi.dataSource?.name ?? '',
                            style: TextStyle(
                              color: _getCategoryColor(category),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                            ),
                          ),
                          if (_isRecommended(kpi.name ?? '')) ...{
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Recomendado',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          },
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        kpi.name ?? '',
                        style: TextStyle(
                          color: Colors.black /* Brand-Black */,
                          fontSize: 18,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w500,
                          height: 1.30,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        kpi.description ?? '',
                        style: TextStyle(
                          color: AppColor.black.withValues(alpha: 0.5),
                          fontSize: 14,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected
                      ? _getCategoryColor(category)
                      : AppColor.grey.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  bool _isRecommended(String name) {
    const recommendedKpis = [
      'Facturación total',
      'Ocupación del local',
      'Ticket medio',
      '% Personal',
      'Beneficio mensual',
      '% Mercaderías',
      'No shows',
      'Valoraciones (estrellas diarias)',
    ];
    return recommendedKpis.contains(name);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'POS':
        return const Color(0xFF673AB7); // LastApp Purple
      case 'Reservas':
        return Colors.pink; // CoverManager Pink
      case 'Google':
        return Colors.blue;
      case 'Contabilidad':
        return Colors.deepPurple; // Holded Purple
      case 'Laboral':
        return Colors.teal; // Skello Teal
      default:
        return AppColor.primaryLight;
    }
  }

  IconData _getKpiIcon(String category) {
    switch (category) {
      case 'POS':
        return Icons.euro;
      case 'Reservas':
        return Icons.calendar_month;
      case 'Google':
        return Icons.star_border;
      case 'Contabilidad':
        return Icons.trending_up;
      case 'Laboral':
        return Icons.people_outline;
      default:
        return Icons.bar_chart;
    }
  }
}
