import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';

class TimeTabsSelector extends StatelessWidget {
  const TimeTabsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final currentFilter = state.selectedFilter;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F4),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                _buildTab(
                  context,
                  DashboardFilter.ayer,
                  currentFilter == DashboardFilter.ayer,
                  showTrailingSeparator:
                      currentFilter != DashboardFilter.ayer &&
                          currentFilter != DashboardFilter.hoy,
                ),
                _buildTab(
                  context,
                  DashboardFilter.hoy,
                  currentFilter == DashboardFilter.hoy,
                  showTrailingSeparator: currentFilter != DashboardFilter.hoy &&
                      currentFilter != DashboardFilter.semana,
                ),
                _buildTab(
                  context,
                  DashboardFilter.semana,
                  currentFilter == DashboardFilter.semana,
                  showTrailingSeparator:
                      currentFilter != DashboardFilter.semana &&
                          currentFilter != DashboardFilter.mes,
                ),
                _buildTab(
                  context,
                  DashboardFilter.mes,
                  currentFilter == DashboardFilter.mes,
                  showTrailingSeparator: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context,
    DashboardFilter filter,
    bool isSelected, {
    required bool showTrailingSeparator,
  }) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<DashboardBloc>().add(LoadDashboardData(filter));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF4A00B0) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  filter.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
          if (showTrailingSeparator)
            Container(
              height: 16,
              width: 1,
              color: Colors.black12,
            ),
        ],
      ),
    );
  }
}
