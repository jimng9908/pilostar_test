import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class SunruffSelection extends StatelessWidget {
  const SunruffSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        if (state is! BusinessOnboardingLoaded) return const SizedBox.shrink();
        return Column(
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(overscroll: false),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        "Configuración local",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF1A171C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Configura el espacio de tu negocio",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A5565),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Terrace Toggle Card
                      _buildSectionCard(
                        child: Row(
                          children: [
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: AppColor.purple,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "¿Tiene terraza?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Espacio exterior para clientes",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF675C70),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: state.hasTerrace,
                                activeThumbColor: AppColor.white,
                                activeTrackColor: AppColor.primaryLight,
                                inactiveThumbColor: AppColor.white,
                                thumbIcon:
                                    WidgetStateProperty.all(Icon(Icons.circle)),
                                inactiveTrackColor:
                                    AppColor.grey.withValues(alpha: 0.5),
                                trackOutlineColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                onChanged: (value) {
                                  context
                                      .read<BusinessOnboardingBloc>()
                                      .add(ToggleTerrace(value));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Interior Section
                      _buildConfigSection(
                        context,
                        title: "Interior",
                        icon: Icons.restaurant_menu_sharp,
                        iconColor: AppColor.purple,
                        tablesValue: state.interiorTables,
                        capacityValue: state.interiorCapacity,
                        onTablesChanged: (val) => context
                            .read<BusinessOnboardingBloc>()
                            .add(UpdateLocalConfig(interiorTables: val)),
                        onCapacityChanged: (val) => context
                            .read<BusinessOnboardingBloc>()
                            .add(UpdateLocalConfig(interiorCapacity: val)),
                      ),
                      if (state.hasTerrace) ...[
                        const SizedBox(height: 16),
                        // Exterior Section
                        _buildConfigSection(
                          context,
                          title: "Terraza (Exterior)",
                          icon: Icons.wb_sunny_outlined,
                          iconColor: Colors.pink,
                          tablesValue: state.exteriorTables,
                          capacityValue: state.exteriorCapacity,
                          onTablesChanged: (val) => context
                              .read<BusinessOnboardingBloc>()
                              .add(UpdateLocalConfig(exteriorTables: val)),
                          onCapacityChanged: (val) => context
                              .read<BusinessOnboardingBloc>()
                              .add(UpdateLocalConfig(exteriorCapacity: val)),
                        ),
                      ],
                      const SizedBox(height: 24),
                      // Info Banner
                      InfoBox(
                        text:
                            "Descubre cómo influye el clima en tus ventas de sala y terraza.",
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            // Footer Buttons
            SafeArea(
              bottom: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'Siguiente',
                      textColor: AppColor.white,
                      onPressed: _hasValid(state)
                          ? () {
                              context
                                  .read<BusinessOnboardingBloc>()
                                  .add(ConfirmLocalConfig());
                            }
                          : null,
                    ),
                    const SizedBox(height: 8),
                    CustomButton(
                      text: 'Atrás',
                      textColor: AppColor.primary,
                      backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                      onPressed: () => context
                          .read<BusinessOnboardingBloc>()
                          .add(BackToPrevious()),
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

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF2F2F2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildConfigSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required int tablesValue,
    required int capacityValue,
    required Function(int) onTablesChanged,
    required Function(int) onCapacityChanged,
  }) {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInputRow(
            icon: Icons.table_bar_outlined,
            iconColor: iconColor,
            label: "Mesas",
            value: tablesValue,
            onChanged: onTablesChanged,
          ),
          const SizedBox(height: 16),
          _buildInputRow(
            icon: Icons.group_outlined,
            iconColor: iconColor,
            label: "Comensales (capacidad)",
            value: capacityValue,
            onChanged: onCapacityChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow({
    required IconData icon,
    required String label,
    required int value,
    required Color iconColor,
    required Function(int) onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: AppColor.textTertiaryDark),
          ),
        ),
        Container(
          width: 80,
          height: 48,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.border),
          ),
          child: TextFormField(
            initialValue: value == 0 ? '' : value.toString(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (val) {
              final parsed = int.tryParse(val) ?? 0;
              onChanged(parsed);
            },
          ),
        ),
      ],
    );
  }

  bool _hasValid(BusinessOnboardingLoaded state) {
    if (state.hasTerrace == true &&
        state.exteriorTables > 0 &&
        state.exteriorCapacity > 0 &&
        state.interiorTables > 0 &&
        state.interiorCapacity > 0) {
      return true;
    }
    if (state.hasTerrace == false &&
        state.interiorTables > 0 &&
        state.interiorCapacity > 0) {
      return true;
    }
    return false;
  }
}
