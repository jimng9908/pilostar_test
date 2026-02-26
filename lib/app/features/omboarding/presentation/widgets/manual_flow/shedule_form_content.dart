// presentation/widgets/schedule_form_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'day_selector.dart';

class ScheduleFormContent extends StatelessWidget {
  final String label;
  const ScheduleFormContent({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        final selectedDaysKeys = state.inputData.keys.toList();
        debugPrint("Selected Days Keys: $selectedDaysKeys");
        final selectedDay = state.selectedDay;

        // Calcular días que ya están en otros grupos
        final List<String> disabledDays = [];
        for (final group in state.savedGroups) {
          for (final day in group.keys) {
            final capitalized = day[0].toUpperCase() + day.substring(1);
            disabledDays.add(capitalized);
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DaySelector(
              label: label,
              selectedDays: selectedDaysKeys,
              disabledDays: disabledDays,
              onDayToggled: (day) {
                if (state.inputData.containsKey(day)) {
                  context.read<ScheduleBloc>().add(RemoveDayEvent(day));
                } else {
                  context.read<ScheduleBloc>().add(SelectDayEvent(day));
                }
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.access_time, size: 18),
                          SizedBox(width: 8),
                          Text("Apertura",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TimePickerBox(day: selectedDay, type: 'start'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.access_time, size: 18),
                          SizedBox(width: 8),
                          Text("Cierre",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TimePickerBox(day: selectedDay, type: 'end'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
