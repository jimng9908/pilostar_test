import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/config/app_color.dart';

class DaySelector extends StatelessWidget {
  final String label;
  final List<String> selectedDays;
  final List<String> disabledDays;
  final ValueChanged<String> onDayToggled;

  const DaySelector({
    super.key,
    required this.label,
    required this.selectedDays,
    this.disabledDays = const [],
    required this.onDayToggled,
  });

  @override
  Widget build(BuildContext context) {
    final days = [
      {"full": "Lunes", "short": "Lun"},
      {"full": "Martes", "short": "Mar"},
      {"full": "Miércoles", "short": "Mié"},
      {"full": "Jueves", "short": "Jue"},
      {"full": "Viernes", "short": "Vie"},
      {"full": "Sábado", "short": "Sáb"},
      {"full": "Domingo", "short": "Dom"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: days.map((day) {
            final isSelected = selectedDays.contains(day["full"]);
            final isDisabled = disabledDays.contains(day["full"]);

            return GestureDetector(
              onTap: isDisabled ? null : () => onDayToggled(day["full"]!),
              child: Opacity(
                opacity: isDisabled ? 0.3 : 1.0,
                child: Container(
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.primary : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          isSelected ? AppColor.primary : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    day["short"]!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
