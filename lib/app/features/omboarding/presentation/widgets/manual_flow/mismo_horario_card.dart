import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class MismoHorarioCard extends StatelessWidget {
  const MismoHorarioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mismo horario todos los días",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Aplicar el mismo horario de lunes a domingo",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: state.isSameScheduleEveryDay,
                  onChanged: (val) {
                    if (val) {
                      final currentDayData = state.inputData[state.selectedDay];
                      final start = currentDayData?['start'];
                      final end = currentDayData?['end'];

                      if (start == null ||
                          end == null ||
                          start == "--:--" ||
                          end == "--:--") {
                        CustomNotification.show(
                          context,
                          title: 'Información',
                          message: 'Debes definir un horario primero',
                          type: NotificationType.info,
                        );
                        return;
                      }
                    }

                    context
                        .read<ScheduleBloc>()
                        .add(ToggleSameScheduleEvent(val));
                  },
                  activeThumbColor: AppColor.white,
                  activeTrackColor: AppColor.primaryLight,
                  inactiveThumbColor: AppColor.white,
                  inactiveTrackColor: AppColor.grey.withValues(alpha: 0.5),
                  thumbIcon: WidgetStateProperty.all(Icon(Icons.circle)),
                  trackOutlineColor:
                      WidgetStateProperty.all(Colors.transparent),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
