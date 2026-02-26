// presentation/widgets/schedule_list_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ScheduleListContent extends StatelessWidget {
  final VoidCallback onEditPressed;
  const ScheduleListContent({super.key, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    final groups = context.watch<ScheduleBloc>().state.savedGroups;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            itemCount: groups.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ScheduleSummaryTile(
                group: groups[index],
                index: index,
              );
            },
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => onEditPressed(),
            icon: Icon(Icons.add_circle_outline, color: AppColor.primaryLight),
            label: Text(
              groups.isEmpty ? "Agregar horario" : "Agregar otro horario",
              style: TextStyle(
                color: AppColor.primaryLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
