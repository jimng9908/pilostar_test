import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ScheduleViewSelector extends StatelessWidget {
  const ScheduleViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        final scheduleState = context.watch<ScheduleBloc>().state;

        // Verificar si hay al menos un rango de horario definido
        bool hasValidSchedule = false;
        if (state.isEditing) {
          // En modo edición, revisamos inputData
          hasValidSchedule = scheduleState.inputData.values.any((day) {
            final start = day['start'] ?? "--:--";
            final end = day['end'] ?? "--:--";
            return start != "--:--" && end != "--:--";
          });
        } else {
          hasValidSchedule = scheduleState.savedGroups.isNotEmpty &&
              scheduleState.savedGroups.first.isNotEmpty;
        }
        return Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  overscroll: false,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _buildHeader(context),
                        if (state.isEditing) ...[
                          const MismoHorarioCard(),
                          const SizedBox(height: 25),
                          const ScheduleFormContent(
                              label: "Días de servicio *"),
                          SizedBox(height: 2.0.hp(context)),
                        ] else ...[
                          ScheduleListContent(onEditPressed: () {
                            context
                                .read<ScheduleBloc>()
                                .add(ToggleEditModeEvent(true));
                          }),
                          const SizedBox(height: 25),
                        ],
                        const InfoBox(
                          text:
                              "Los horarios nos ayudan a calcular mejor la ocupación y rendimiento por franjas horarias",
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SafeArea(
                bottom: true,
                child: Column(
                  children: [
                    CustomButton(
                      text: state.isEditing ? "Guardar" : "Siguiente",
                      textColor: AppColor.white,
                      onPressed: hasValidSchedule
                          ? () {
                              if (state.isEditing) {
                                context
                                    .read<ScheduleBloc>()
                                    .add(SaveSchedulesEvent());
                              } else {
                                context.read<BusinessOnboardingBloc>().add(
                                    SaveTimeSchedulesEvent(
                                        savedGroups:
                                            scheduleState.savedGroups));
                              }
                            }
                          : null,
                    ),
                    const SizedBox(height: 8),
                    // Botón secundario: "Atrás"
                    CustomButton(
                      text: state.isEditing ? "Cancelar" : "Atrás",
                      textColor: AppColor.purple,
                      backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                      onPressed: () {
                        if (state.isEditing) {
                          context
                              .read<ScheduleBloc>()
                              .add(ToggleEditModeEvent(false));
                        } else {
                          context
                              .read<ScheduleBloc>()
                              .add(ToggleEditModeEvent(true));
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(BackToPrevious());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Horario de servicio',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF1A171C),
              fontSize: 22,
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w500,
              height: 1.30,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Configura los horarios e apertura de tu negocio",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4A5565),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.43,
              letterSpacing: -0.15,
            ),
          ),
        ],
      ),
    );
  }
}
