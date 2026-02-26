import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/home/domain/entity/index.dart';
import 'package:rockstardata_apk/app/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';

class DetailChartSection extends StatelessWidget {
  final ChartDataEntity data;

  const DetailChartSection({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        String selectedCategory = 'Facturación';
        if (state is DashboardLoaded) {
          selectedCategory = state.selectedCategory;
        }

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tabs de Categoría
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F4),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    _buildTab(context, "Facturación",
                        selectedCategory == "Facturación"),
                    _buildTab(
                        context, "Reservas", selectedCategory == "Reservas"),
                    _buildTab(
                        context, "Personal", selectedCategory == "Personal"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Summary Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Icon(Icons.payments_outlined,
                              color: AppColor.primary, size: 24),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedCategory == "Facturación"
                                    ? "Facturación Total"
                                    : selectedCategory == "Reservas"
                                        ? "Total Reservas"
                                        : "Coste Personal",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                selectedCategory == "Facturación"
                                    ? "LastApp"
                                    : selectedCategory == "Reservas"
                                        ? "CoverManager"
                                        : "Holded",
                                style: TextStyle(
                                  color: selectedCategory == "Facturación"
                                      ? AppColor.purple
                                      : selectedCategory == "Reservas"
                                          ? AppColor.darkPink
                                          : AppColor.purple,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                  letterSpacing: 0.12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    selectedCategory == "Facturación"
                        ? "3.847€"
                        : selectedCategory == "Reservas"
                            ? "154"
                            : "1.240€",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Chart Row
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 0,
                        sections: _buildChartSections(selectedCategory, data),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: _buildLegendItems(selectedCategory, data),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(BuildContext context, String label, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            context.read<DashboardBloc>().add(ChangeChartCategory(label)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.purple : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections(
      String category, ChartDataEntity data) {
    // Definimos los porcentajes según la categoría (puedes parametrizar esto luego con 'data')
    double value1 = 65;
    double value2 = 35;

    if (category == "Reservas") {
      value1 = 70;
      value2 = 30;
    } else if (category == "Personal") {
      value1 = 80;
      value2 = 20;
    }

    return [
      PieChartSectionData(
        color: AppColor.primary,
        value: value1,
        title:
            '${NumberFormat.decimalPattern('es_ES').format(value1)}%', // Texto embebido
        radius: 50, // Grosor del anillo/círculo
        showTitle: true,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Color para que resalte sobre el morado
        ),
      ),
      PieChartSectionData(
        color: AppColor.darkPink,
        value: value2,
        title:
            '${NumberFormat.decimalPattern('es_ES').format(value2)}%', // Texto embebido
        radius: 50,
        showTitle: true,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  List<Widget> _buildLegendItems(String category, ChartDataEntity data) {
    if (category == "Facturación") {
      return [
        _legendItem("Comida", 2500, AppColor.primary),
        const Divider(height: 16),
        _legendItem("Bebida", 1347, AppColor.darkPink),
      ];
    } else if (category == "Reservas") {
      return [
        _legendItem("Confirmadas", 108, AppColor.primary),
        const Divider(height: 16),
        _legendItem("Pendientes", 46, AppColor.darkPink),
      ];
    } else {
      return [
        _legendItem("Salarios", 1000, AppColor.primary),
        const Divider(height: 16),
        _legendItem("Seguros", 240, AppColor.darkPink),
      ];
    }
  }

  Widget _legendItem(String label, double value, Color color) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(
          label == "Confirmadas" || label == "Pendientes"
              ? NumberFormat.decimalPattern('es_ES').format(value)
              : "${NumberFormat.decimalPattern('es_ES').format(value)} €",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.grey[800]),
        ),
      ],
    );
  }
}
