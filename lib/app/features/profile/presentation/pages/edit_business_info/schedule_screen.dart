import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Horario",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) {
          if (previous is ProfileLoaded && current is ProfileLoaded) {
            return previous.isSaving != current.isSaving;
          }
          return false;
        },
        listener: (context, state) {
          if (state is ProfileLoaded && !state.isSaving) {
            context.pop();
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            return BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, scheduleState) {
                if (profileState is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (profileState is ProfileLoaded) {
                  final schedule = profileState.schedule;
                  final isEditing =
                      scheduleState.isEditing || profileState.isEditingProfile;

                  return Column(
                    children: [
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Info Context
                                _buildInfoHeader(context),
                                const SizedBox(height: 20),

                                // Stats Card
                                ScheduleStatsCard(
                                  totalOpenDays: schedule.totalOpenDays,
                                ),
                                const SizedBox(height: 20),

                                if (isEditing) ...[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Editar Horario Semanal",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      // El formulario donde el usuario interactúa
                                      const ScheduleFormContent(
                                        label: 'Configurar días de servicio *',
                                      ),
                                    ],
                                  ),
                                ] else ...[
                                  // Si isEditing es false (estado por defecto), mostramos la lista de solo lectura
                                  ScheduleListContent(onEditPressed: () {
                                    context
                                        .read<ScheduleBloc>()
                                        .add(ToggleEditModeEvent(true));
                                    context
                                        .read<ProfileBloc>()
                                        .add(ToggleEditProfile());
                                  }),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Footer Safe Area with Save Button
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomButton(
                          onPressed: !profileState.isSaving
                              ? () {
                                  final scheduleBloc =
                                      context.read<ScheduleBloc>();
                                  final profileBloc =
                                      context.read<ProfileBloc>();

                                  // 1. Si está editando, confirmamos el grupo actual en ScheduleBloc
                                  if (isEditing) {
                                    scheduleBloc.add(SaveSchedulesEvent());
                                  }

                                  // Obtenemos los grupos guardados (incluyendo el recién guardado)
                                  final savedGroups =
                                      scheduleBloc.state.savedGroups;

                                  // 2. Mapear de List<Map<String, String>> (ScheduleBloc) a ProfileSchedule
                                  final List<ProfileDailySchedule> updatedDays =
                                      [];
                                  final weekDays = [
                                    'Lunes',
                                    'Martes',
                                    'Miércoles',
                                    'Jueves',
                                    'Viernes',
                                    'Sábado',
                                    'Domingo'
                                  ];

                                  for (final dayName in weekDays) {
                                    final lowerDay = dayName.toLowerCase();
                                    String? range;
                                    for (final group in savedGroups) {
                                      if (group.containsKey(lowerDay)) {
                                        range = group[lowerDay];
                                        break;
                                      }
                                    }

                                    if (range != null) {
                                      final parts = range.split('-');
                                      updatedDays.add(ProfileDailySchedule(
                                        dayName: dayName,
                                        isOpen: true,
                                        openTime:
                                            parts.isNotEmpty ? parts[0] : '',
                                        closeTime:
                                            parts.length > 1 ? parts[1] : '',
                                      ));
                                    } else {
                                      updatedDays.add(ProfileDailySchedule(
                                        dayName: dayName,
                                        isOpen: false,
                                        openTime: '',
                                        closeTime: '',
                                      ));
                                    }
                                  }

                                  final updatedSchedule = ProfileSchedule(
                                    days: updatedDays,
                                    totalOpenDays: updatedDays
                                        .where((d) => d.isOpen)
                                        .length,
                                  );

                                  // 3. Actualizar el perfil con el nuevo horario
                                  profileBloc
                                      .add(UpdateSchedule(updatedSchedule));

                                  // 4. Guardar cambios en el servidor/repo
                                  profileBloc.add(const SaveProfile());
                                }
                              : null,
                          backgroundColor: AppColor.primary,
                          isLoading: profileState.isSaving,
                          text: "Guardar",
                          textColor: AppColor.white,
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: Text("Error loading schedule"));
              },
            );
          },
        ),
      ),
    );
  }

  _buildInfoHeader(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline,
                  color: Color(0xFF560BAD), size: 20),
              const SizedBox(width: 10),
              const Text(
                "Configura tus días y horas de apertura",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF560BAD),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Esta información ayuda a calcular métricas por hora punta y comparar rendimiento por día de la semana.",
            style: TextStyle(
              color: Color(0xFF560BAD),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
