// presentation/widgets/time_picker_box.dart
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class TimePickerBox extends StatelessWidget {
  final String day;
  final String type;

  const TimePickerBox({super.key, required this.day, required this.type});

  @override
  Widget build(BuildContext context) {
    final time = context.select(
      (ScheduleBloc bloc) => bloc.state.inputData[day]?[type] ?? "--:--",
    );
    return GestureDetector(
      onTap: () {
        BottomPicker.time(
          height: MediaQuery.of(context).size.height * 0.3,
          headerBuilder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Establecer hora",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColor.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColor.black,
                  ),
                ),
              ],
            );
          },
          onChange: (date) {
            if (context.mounted) {
              if (date is DateTime) {
                final formatted =
                    "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                context
                    .read<ScheduleBloc>()
                    .add(UpdateTimeEvent(day, type, formatted));
              }
            }
          },
          initialTime: Time(hours: type == "start" ? 8 : 17, minutes: 0),
          buttonStyle: BoxDecoration(
            color: AppColor.purple,
            borderRadius: BorderRadius.circular(12),
          ),
          useSafeArea: true,
          buttonContent: Center(
            child: Text(
              "Guardar",
              style: TextStyle(
                color: AppColor.white,
              ),
            ),
          ),
        ).show(context);
      },
      child: Container(
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
