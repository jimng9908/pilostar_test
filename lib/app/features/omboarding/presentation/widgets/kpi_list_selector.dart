import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class KpiListSelector extends StatelessWidget {
  const KpiListSelector({super.key});

  static const List<String> _filters = [
    'Todos',
    'POS',
    'Reservas',
    'Google',
    'Contabilidad',
    'Laboral',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      buildWhen: (previous, current) {
        if (previous is BusinessOnboardingLoaded &&
            current is BusinessOnboardingLoaded) {
          return previous.fetchingData != current.fetchingData ||
              previous.selectedKpi != current.selectedKpi ||
              previous.kpiFilter != current.kpiFilter ||
              previous.kpis != current.kpis ||
              previous.hasError != current.hasError;
        }
        return true;
      },
      builder: (context, state) {
        if (state is! BusinessOnboardingLoaded) {
          return const SizedBox.shrink();
        }

        final isFetchingData = state.fetchingData;
        final allKpis = state.kpis;
        final selectedIds = state.selectedKpi;
        final currentFilter = state.kpiFilter;

        final activeFilters = {'Todos'};
        for (final kpi in allKpis) {
          activeFilters.addAll(_getKpiCategories(kpi));
        }

        final visibleFilters =
            _filters.where((f) => activeFilters.contains(f)).toList();

        final filteredKpis = allKpis.where((k) {
          final name = _normalize(k.name ?? '');
          final source = _normalize(k.dataSource?.name ?? '');

          // Exclusiones globales
          if (source.contains('aemet')) return false;
          if (name.contains('asientos')) return false;

          // Exclusiones solicitadas (normalizadas)
          final excludedSubstrings = [
            'deuda total y ranking de acreedores',
            'top 3 gastos del periodo',
            'ratios de salud',
            'comparativa de ingresos',
            'gastos por categoria',
            'saldo de tesoreria',
            'ingresos y gastos total',
            'beneficio real (ebitda)',
          ];

          if (excludedSubstrings.any((excluded) => name.contains(excluded))) {
            return false;
          }

          if (currentFilter == 'Todos') return true;
          return _getKpiCategories(k).contains(currentFilter);
        }).toList();

        return Column(
          children: [
            // Header
            Text(
              'Elige tus KPIs favoritos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1A171C),
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.33,
                letterSpacing: 0.07,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Elige de 6 a 8 métricas para destacar. Gestiona tu selección desde el Perfil.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF666666) /* Brand-Greyscale-600 */,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: visibleFilters.map((filter) {
                  final isSelected = currentFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(ChangeKpiFilter(filter));
                        }
                      },
                      labelStyle: GoogleFonts.outfit(
                        fontSize: 14,
                        color: isSelected ? Colors.white : AppColor.black,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      selectedColor: AppColor.purple,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? AppColor.purple
                              : AppColor.grey.withValues(alpha: 0.3),
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Selection Badge
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColor.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${selectedIds.length} seleccionados',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(overscroll: false),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  physics: const ClampingScrollPhysics(),
                  itemCount: filteredKpis.length,
                  itemBuilder: (context, index) {
                    final kpi = filteredKpis[index];
                    final isSelected = selectedIds.any((k) => k.id == kpi.id);

                    return KpiCard(
                      kpi: kpi,
                      isSelected: isSelected,
                      category: _getPrimaryCategory(kpi),
                      onTap: () {
                        if (!isSelected && selectedIds.length < 8) {
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(ToggleKpi(kpi));
                        } else if (isSelected) {
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(ToggleKpi(kpi));
                        } else {
                          EasyLoadingHelper.showToastLila(
                              'Solo puedes seleccionar 8 KPIs');
                        }
                      },
                    );
                  },
                ),
              ),
            ),

            // Footer
            SafeArea(
              bottom: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CustomButton(
                    text: 'Siguiente',
                    textColor: Colors.white,
                    isLoading: isFetchingData,
                    onPressed: selectedIds.length >= 6 &&
                            selectedIds.length <= 8 &&
                            !isFetchingData
                        ? () {
                            context
                                .read<BusinessOnboardingBloc>()
                                .add(ConfirmKpiSelection());
                          }
                        : null,
                  ),
                  const SizedBox(height: 8),
                  CustomButton(
                    text: 'Atrás',
                    textColor: AppColor.purple,
                    backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                    onPressed: () {
                      context
                          .read<BusinessOnboardingBloc>()
                          .add(BackToPrevious());
                    },
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');
  }

  List<String> _getKpiCategories(KpiEntity kpi) {
    final categories = <String>['Todos'];
    final sourceName = kpi.dataSource?.name?.toLowerCase() ?? '';

    // POS: LastApp, Agora
    if (sourceName.contains('lastapp') || sourceName.contains('agora')) {
      categories.add('POS');
    }

    // RESERVAS: TspoonLab, CoverManager
    if (sourceName.contains('tspoonlab') ||
        sourceName.contains('covermanager')) {
      categories.add('Reservas');
    }

    // Google: Google Maps scrapper
    if (sourceName.contains('google')) {
      categories.add('Google');
    }

    // Contabilidad: Holded
    if (sourceName.contains('holded')) {
      categories.add('Contabilidad');
    }
    // Laboral: Skello
    if (sourceName.contains('skello')) {
      categories.add('Laboral');
    }

    return categories;
  }

  String _getPrimaryCategory(KpiEntity kpi) {
    final categories = _getKpiCategories(kpi);
    if (categories.length > 1) {
      return categories[1]; // First category after 'Todos'
    }
    return 'Otros';
  }
}
