import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/config/app_color.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import '../../bloc/profile_bloc.dart';
import '../../../domain/entities/data_source.dart';

class ConfigKpiScreen extends StatelessWidget {
  final ProfileDataSource datasource;

  const ConfigKpiScreen({super.key, required this.datasource});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: AppColor.white,
            surfaceTintColor: AppColor.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black87, size: 20),
              onPressed: () => context.pop(),
            ),
            title: const Text(
              'Configurar KPIs',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildHeaderCard(datasource),
                      const SizedBox(height: 24),
                      _buildInfoBanner(),
                      const SizedBox(height: 24),
                      ...datasource.kpisList.map((kpi) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildKpiCard(context, datasource, kpi),
                          )),
                    ],
                  ),
                ),
              ),
              _buildSaveButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderCard(ProfileDataSource source) {
    // Helper to get icon for header (reusing logic or mapping here)
    IconData getIcon(String id) {
      switch (id) {
        case 'lastapp':
          return Icons.shopping_cart_outlined;
        case 'covermanager':
          return Icons.calendar_today_outlined;
        case 'holded':
          return Icons.description_outlined;
        case 'agora':
          return Icons.bar_chart_rounded;
        case 'google-maps':
          return Icons.star_border;
        case 'tspoonlab':
          return Icons.restaurant_outlined;
        default:
          return Icons.device_hub_outlined;
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          top: BorderSide(color: AppColor.primary, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(getIcon(source.id), color: AppColor.primary, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  source.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bar_chart,
                          size: 14, color: Color(0xFF7B1FA2)),
                      const SizedBox(width: 6),
                      Text(
                        "${source.kpis} KPIs activos",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7B1FA2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0x19560BAD),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.65,
            color: const Color(0xFF540BA8) /* Brand-Primary-800 */,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF7B1FA2), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Selecciona tus indicadores clave.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Activa los KPI que prefieras y ajusta tu vista en cualquier momento.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7B1FA2).withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(
      BuildContext context, ProfileDataSource datasource, DataSourceKpi kpi) {
    return GestureDetector(
      onTap: () {
        context.read<ProfileBloc>().add(
              ToggleKpiSelection(kpiId: kpi.id, dataSourceId: datasource.id),
            );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kpi.isActive ? AppColor.primary : Colors.transparent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5EDFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.euro, color: Color(0xFF560BAD), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kpi.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    kpi.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kpi.isActive ? AppColor.primary : Colors.grey[300]!,
                  width: 2,
                ),
                color: kpi.isActive ? AppColor.primary : Colors.transparent,
              ),
              child: kpi.isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
          onPressed: () => Navigator.pop(context),
          text: "Guardar",
          textColor: Colors.white,
        ),
      ),
    );
  }
}
