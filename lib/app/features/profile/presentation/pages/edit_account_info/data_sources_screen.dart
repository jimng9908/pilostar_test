import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/domain/entities/data_source.dart';
import 'package:rockstardata_apk/app/features/profile/presentation/bloc/profile_bloc.dart';

class DataSourcesScreen extends StatelessWidget {
  const DataSourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(const LoadDataSources());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Fuentes de Datos",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded) {
            if (state.isLoadingDataSources && state.dataSources.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileBloc>().add(const LoadDataSources());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Summary Banner
                      if (state.dataSourcesSummary != null)
                        _buildSummaryBanner(state.dataSourcesSummary!)
                      else
                        const SizedBox.shrink(),

                      const SizedBox(height: 16),
                      _buildScheduleCard(context),
                      const SizedBox(height: 16),

                      const Text(
                        "Integraciones Activas",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Integration Cards
                      ...state.dataSources.map((source) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildIntegrationCard(
                              context: context,
                              dataSource: source,
                              icon: _getIcon(source.id),
                              iconColor: _getIconColor(source.id),
                              title: source.title,
                              isRequired: source.isRequired,
                              description: source.description,
                              status: source.status,
                              lastSync: source.lastSync,
                              kpis: source.kpis,
                              borderColor: _getBorderColor(source.id),
                              hasUnlink: source.hasUnlink,
                            ),
                          )),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  IconData _getIcon(String id) {
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
      case 'skello':
        return Icons.group;
      default:
        return Icons.device_hub_outlined;
    }
  }

  Color _getIconColor(String id) {
    switch (id) {
      case 'lastapp':
        return Colors.deepPurple;
      case 'covermanager':
        return Colors.pink;
      case 'holded':
        return Colors.purple;
      case 'agora':
        return Colors.teal;
      case 'google-maps':
        return AppColor.primary;
      case 'tspoonlab':
        return AppColor.darkPink;
      case 'skello':
        return AppColor.ligthGreen;
      default:
        return Colors.grey;
    }
  }

  Color _getBorderColor(String id) {
    return _getIconColor(id);
  }

  Widget _buildSummaryBanner(DataSourcesSummary summary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.50, 0.00),
          end: Alignment(0.50, 1.00),
          colors: [const Color(0xFF560BAD), const Color(0xFF7F38A5)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${summary.connectedCount}/${summary.totalCount}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Fuentes conectadas",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bolt_outlined,
                    color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  label: "KPIs Totales",
                  value: summary.totalKpis.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryItem(
                  label: "Última Sync",
                  value: "Hace ${summary.lastSync}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    bool isRequired = false,
    required String description,
    required String status,
    required String lastSync,
    required String kpis,
    required Color borderColor,
    bool hasUnlink = false,
    required ProfileDataSource dataSource,
    required BuildContext context,
  }) {
    final bool isDisconnected = status == "Desconectado";

    if (isDisconnected) {
      return _buildDisconnectedCard(
        icon: icon,
        title: title,
        context: context,
        dataSourceId: dataSource.id,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          top: BorderSide(color: borderColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: iconColor, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          if (isRequired) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3E5F5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "REQUERIDA",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF7B1FA2),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Conectado",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildCardInfo(label: "Última Sync", value: lastSync),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCardInfo(label: "KPIs", value: kpis),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "Sincronizar",
                    backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                    textColor: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      context.pushNamed(
                        RouteName.configKpis,
                        extra: dataSource,
                      );
                    },
                    text: "Configurar",
                    backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                    textColor: Colors.black87,
                  ),
                ),
                if (hasUnlink) ...[
                  const SizedBox(width: 12),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.link_off,
                          color: Colors.redAccent, size: 18),
                      onPressed: () => _showDisconnectBottomSheet(
                        context,
                        dataSourceId: dataSource.id,
                        title: title,
                        kpis: kpis,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardInfo({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisconnectedCard({
    required IconData icon,
    required String title,
    required BuildContext context,
    required String dataSourceId,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.grey[600], size: 28),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    "Desconectado",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                context
                    .read<ProfileBloc>()
                    .add(ReconnectDataSource(dataSourceId));
              },
              backgroundColor: AppColor.primary,
              text: "Reconectar",
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showDisconnectBottomSheet(
    BuildContext context, {
    required String dataSourceId,
    required String title,
    required String kpis,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "¿Desconectar $title?",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Dejarás de recibir actualizaciones y los $kpis KPIs asociados no estarán disponibles.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFE0E0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: Color(0xFFD32F2F), size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Esta acción desactivará todos los KPIs de $title",
                        style: TextStyle(
                          color: const Color(0xFFCC3E59),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: -0.38,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: () {
                  context
                      .read<ProfileBloc>()
                      .add(DisconnectDataSource(dataSourceId));
                  Navigator.pop(context);
                },
                backgroundColor: const Color(0xFFD83C5E),
                text: "Desconectar",
                textColor: Colors.white,
              ),
              const SizedBox(height: 12),
              CustomButton(
                onPressed: () => Navigator.pop(context),
                text: "Cancelar",
                backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                textColor: AppColor.primary,
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScheduleCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 8,
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF6A1B9A)),
                  Text(
                    'Sincronizar todo',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.47,
                      letterSpacing: -0.60,
                    ),
                  ),
                ],
              ),
              const Text(
                'Prepararemos tus datos con los últimos datos. El proceso llevará unos minutos.',
                style: TextStyle(
                  color: Color(0xCC560AAC),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.40,
                  letterSpacing: -0.38,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Sincronizar',
            textColor: AppColor.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
