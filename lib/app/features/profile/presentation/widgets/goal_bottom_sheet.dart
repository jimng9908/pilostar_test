import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class GoalBottomSheet extends StatelessWidget {
  const GoalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileLoaded || state.editingGoal == null) {
          return const SizedBox.shrink();
        }

        final goal = state.editingGoal!;
        final isEditing = goal.id.isNotEmpty;

        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? "Editar objetivo" : "Crear objetivo",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context.read<ProfileBloc>().add(const CancelGoalForm());
                      context.pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Define un objetivo basado en los datos del año pasado y establece umbrales de alerta",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        const SizedBox(height: 20),

                        // Nombre del objetivo
                        _buildLabel("Nombre del objetivo"),
                        _buildDropdown(
                          value: goal.title,
                          items: const [
                            "Ventas mensuales",
                            "Clientes mensuales",
                            "Ticket medio",
                            "Reservaciones",
                            "Gastos máximos mensuales",
                            "Ingresos mensuales",
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              context.read<ProfileBloc>().add(
                                  UpdateGoalForm(goal.copyWith(title: val)));
                            }
                          },
                        ),
                        const SizedBox(height: 15),

                        // Dropdowns Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Categoría"),
                                  _buildDropdown(
                                    value: goal.category,
                                    items: [
                                      "Ventas",
                                      "Clientes",
                                      "Ticket medio",
                                      "Margen promedio/plato",
                                      "Margen",
                                    ],
                                    onChanged: (val) {
                                      String? newUnit = goal.unit;
                                      // Validar y ajustar unidad según categoría
                                      if (val == "Ventas" ||
                                          val == "Ticket medio" ||
                                          val == "Margen promedio/plato") {
                                        newUnit = "€ Euros";
                                      } else if (val == "Clientes") {
                                        newUnit = '';
                                      } else if (val == "Margen") {
                                        newUnit = "%";
                                      }

                                      context.read<ProfileBloc>().add(
                                          UpdateGoalForm(goal.copyWith(
                                              category: val, unit: newUnit)));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Periodo"),
                                  _buildDropdown(
                                    value: goal.period,
                                    items: [
                                      "Semanal",
                                      "Mensual",
                                      "Trimestral",
                                      "Anual"
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        context.read<ProfileBloc>().add(
                                            UpdateGoalForm(
                                                goal.copyWith(period: val)));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Unidad"),
                                  _buildDropdown(
                                    value: goal.unit,
                                    items: (goal.category == "Ventas" ||
                                            goal.category == "Ticket medio" ||
                                            goal.category ==
                                                "Margen promedio/plato")
                                        ? ["€ Euros"]
                                        : (goal.category == "Clientes"
                                            ? []
                                            : (goal.category == "Margen"
                                                ? ["%"]
                                                : ["€ Euros", "%"])),
                                    onChanged: (val) {
                                      if (val != null) {
                                        context.read<ProfileBloc>().add(
                                            UpdateGoalForm(
                                                goal.copyWith(unit: val)));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Reference Data
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            const Text("Datos del año pasado (referencia)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F0FF), // Light purple bg
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.deepPurple.shade100),
                          ),
                          child: Text(
                            "${NumberFormat.decimalPattern('es_ES').format(goal.lastYearAmount)} ${goal.unit}",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Este valor se usa como base para calcular tu nuevo objetivo",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 10),
                        ),
                        const SizedBox(height: 15),

                        // Slider Adjustment
                        Row(
                          children: [
                            const Icon(Icons.trending_up, size: 16),
                            const SizedBox(width: 8),
                            Text(
                                "Ajuste de objetivo: ${(goal.targetIncrease * 100).toStringAsFixed(2)}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        Slider(
                          value: goal.targetIncrease.abs(),
                          min: 0,
                          max: 1.0,
                          activeColor: const Color(0xFF6200EA),
                          secondaryActiveColor: AppColor.border,
                          inactiveColor: const Color(0xFFF5EDFF),
                          overlayColor: WidgetStatePropertyAll(AppColor.border),
                          thumbColor: AppColor.white,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(UpdateGoalForm(
                                goal.copyWith(targetIncrease: val)));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("0%",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              Text("50%",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                              Text("+100%",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Calculated Goal Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF2FF),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.deepPurple.shade50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Objetivo calculado",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${NumberFormat.decimalPattern('es_ES').format(_calculateTarget(goal.amountVsLastYear, goal.targetIncrease))} ${goal.unit.contains('Euros') ? '€' : goal.unit}",
                                    style: const TextStyle(
                                        color: Color(0xFF6200EA),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Año pasado",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${NumberFormat.decimalPattern('es_ES').format(goal.amountVsLastYear)} ${goal.unit.contains('Euros') ? '€' : goal.unit}",
                                    style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Alert Thresholds
                        Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: Colors.orange, size: 16),
                            const SizedBox(width: 8),
                            const Text("Umbrales de alerta",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "Alerta (warning): ${goal.alertThreshold}% del objetivo",
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold)),
                        Slider(
                          value: goal.alertThreshold.toDouble(),
                          min: 0,
                          max: 100,
                          activeColor: const Color(0xFF6200EA),
                          secondaryActiveColor: AppColor.border,
                          inactiveColor: const Color(0xFFF5EDFF),
                          overlayColor: WidgetStatePropertyAll(AppColor.border),
                          thumbColor: AppColor.white,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(UpdateGoalForm(
                                goal.copyWith(alertThreshold: val.toInt())));
                          },
                        ),
                        Text(
                          "Recibirás una alerta moderada cuando el progreso esté por debajo de este umbral",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 10),
                        ),
                        const SizedBox(height: 10),
                        Text("Crítico: ${goal.criticalThreshold}% del objetivo",
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold)),
                        Slider(
                          value: goal.criticalThreshold.toDouble(),
                          min: 0,
                          max: 100,
                          activeColor: const Color(0xFF6200EA),
                          secondaryActiveColor: AppColor.border,
                          inactiveColor: const Color(0xFFF5EDFF),
                          overlayColor: WidgetStatePropertyAll(AppColor.border),
                          thumbColor: AppColor.white,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(UpdateGoalForm(
                                goal.copyWith(criticalThreshold: val.toInt())));
                          },
                        ),
                        Text(
                          "Recibirás una alerta crítica cuando el progreso esté por debajo de este umbral",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 10),
                        ),

                        const SizedBox(height: 25),

                        // Buttons
                        CustomButton(
                          onPressed: goal.title.isNotEmpty
                              ? () {
                                  context
                                      .read<ProfileBloc>()
                                      .add(const SubmitGoalForm());
                                  Navigator.of(context).pop();
                                }
                              : null,
                          backgroundColor: AppColor.primary,
                          textColor: Colors.white,
                          text: isEditing
                              ? "Actualizar objetivo"
                              : "Crear objetivo",
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          textColor: AppColor.primary,
                          text: "Cancelar",
                          backgroundColor:
                              AppColor.greyDark.withValues(alpha: 0.3),
                          onPressed: () {
                            context
                                .read<ProfileBloc>()
                                .add(const CancelGoalForm());
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateTarget(double base, double increase) {
    if (base == 0) return 0;
    final val = base * (1 + increase);
    return val;
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  Widget _buildDropdown(
      {required String value,
      required List<String> items,
      required ValueChanged<String?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : null,
          hint: Text(value,
              style: const TextStyle(fontSize: 13, color: Colors.black87)),
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  value,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, height: 1.2),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Colors.grey, size: 20),
        ),
      ),
    );
  }
}
