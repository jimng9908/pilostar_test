// presentation/widgets/schedule_summary_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ScheduleSummaryTile extends StatelessWidget {
  final Map<String, String> group;
  final int index;

  const ScheduleSummaryTile({
    super.key,
    required this.group,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Group days by hours
    final Map<String, List<String>> groupedSchedules = {};
    group.forEach((day, hours) {
      if (!groupedSchedules.containsKey(hours)) {
        groupedSchedules[hours] = [];
      }
      groupedSchedules[hours]!.add(day);
    });

    List<Widget> tiles = [];
    groupedSchedules.forEach((hours, days) {
      // Sort days
      days.sort((a, b) => _dayToIndex(a).compareTo(_dayToIndex(b)));
      String title = _formatDays(days);

      tiles.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEEEEEE)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(hours, style: const TextStyle(color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<ScheduleBloc>().add(DeleteGroupEvent(index)),
                  icon: const Icon(Icons.delete_outline,
                      size: 18, color: Colors.grey),
                ),
                TextButton.icon(
                  onPressed: () =>
                      context.read<ScheduleBloc>().add(EditGroupEvent(index)),
                  icon: const Icon(Icons.edit_outlined,
                      size: 18, color: Colors.pinkAccent),
                  label: const Text("Editar",
                      style: TextStyle(color: Colors.pinkAccent)),
                ),
              ],
            ),
          ),
        ),
      );
    });

    return Column(children: tiles);
  }

  int _dayToIndex(String day) {
    switch (day.toLowerCase()) {
      case 'lunes':
        return 1;
      case 'martes':
        return 2;
      case 'miércoles':
      case 'miercoles':
        return 3;
      case 'jueves':
        return 4;
      case 'viernes':
        return 5;
      case 'sábado':
      case 'sabado':
        return 6;
      case 'domingo':
        return 7;
      default:
        return 8;
    }
  }

  String _formatDays(List<String> days) {
    if (days.isEmpty) return "";

    final capitalizedDays = days.map((d) {
      if (d.isEmpty) return d;
      return d[0].toUpperCase() + d.substring(1);
    }).toList();

    if (capitalizedDays.length == 1) return capitalizedDays.first;

    // Verificar si son consecutivos para usar el formato "a"
    bool isConsecutive = true;
    for (int i = 0; i < days.length - 1; i++) {
      if (_dayToIndex(days[i + 1]) != _dayToIndex(days[i]) + 1) {
        isConsecutive = false;
        break;
      }
    }

    if (isConsecutive && capitalizedDays.length >= 3) {
      return "${capitalizedDays.first} a ${capitalizedDays.last}";
    }

    if (capitalizedDays.length == 2) {
      return "${capitalizedDays.first} y ${capitalizedDays.last}";
    }

    // Formato de lista: "Lunes, Miércoles y Viernes"
    final lastDay = capitalizedDays.removeLast();
    return "${capitalizedDays.join(', ')} y $lastDay";
  }
}
