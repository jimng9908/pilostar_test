import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class VenueConfigScreen extends StatelessWidget {
  const VenueConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: const Text(
          'Configuración  del local',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.20,
            letterSpacing: -0.85,
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final config = state.venueConfig;
            return ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Total Capacity Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.50, 0.00),
                          end: Alignment(0.50, 1.00),
                          colors: [
                            const Color(0xFF560BAD),
                            const Color(0xFF7F38A5)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.settings,
                                  color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                "Capacidad Total del Restaurante",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Mesas",
                                      style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.8),
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${config.totalTables}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Comensales",
                                      style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.8),
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${config.totalCapacity}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Has Terrace Toggle
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.wb_sunny_outlined,
                                color: AppColor.primary),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "¿Tiene terraza?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Espacio exterior para clientes",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: config.hasTerrace,
                              activeThumbColor: AppColor.white,
                              activeTrackColor: AppColor.primaryLight,
                              inactiveThumbColor: AppColor.white,
                              inactiveTrackColor:
                                  AppColor.grey.withValues(alpha: 0.5),
                              trackOutlineColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              thumbIcon:
                                  WidgetStateProperty.all(Icon(Icons.circle)),
                              onChanged: (val) {
                                context.read<ProfileBloc>().add(
                                    UpdateVenueConfig(
                                        config.copyWith(hasTerrace: val)));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Interior Section
                    _SectionCard(
                      title: "Interior",
                      icon: Icons.restaurant_menu_outlined,
                      children: [
                        _NumberInput(
                          label: "Mesas",
                          value: config.interiorTables,
                          icon: Icons.table_bar_outlined,
                          iconColor: AppColor.primary,
                          onChanged: (val) {
                            final newConfig =
                                config.copyWith(interiorTables: val);
                            final totalTables = newConfig.interiorTables +
                                newConfig.terraceTables;
                            context.read<ProfileBloc>().add(UpdateVenueConfig(
                                newConfig.copyWith(totalTables: totalTables)));
                          },
                        ),
                        const SizedBox(height: 15),
                        _NumberInput(
                          label: "Comensales (capacidad)",
                          value: config.interiorCapacity,
                          icon: Icons.person_outline,
                          iconColor: AppColor.primary,
                          onChanged: (val) {
                            final newConfig =
                                config.copyWith(interiorCapacity: val);
                            final totalCapacity = newConfig.interiorCapacity +
                                newConfig.terraceCapacity;
                            context.read<ProfileBloc>().add(UpdateVenueConfig(
                                newConfig.copyWith(
                                    totalCapacity: totalCapacity)));
                          },
                        ),
                      ],
                    ),

                    if (config.hasTerrace) ...[
                      const SizedBox(height: 20),
                      // Terrace Section
                      _SectionCard(
                        title: "Terraza (Exterior)",
                        icon: Icons.wb_sunny_outlined,
                        iconColor: Colors.pinkAccent,
                        children: [
                          _NumberInput(
                            label: "Mesas",
                            value: config.terraceTables,
                            icon: Icons.table_bar_outlined,
                            iconColor: AppColor.darkPink,
                            onChanged: (val) {
                              final newConfig =
                                  config.copyWith(terraceTables: val);
                              final totalTables = newConfig.interiorTables +
                                  newConfig.terraceTables;
                              context.read<ProfileBloc>().add(UpdateVenueConfig(
                                  newConfig.copyWith(
                                      totalTables: totalTables)));
                            },
                          ),
                          const SizedBox(height: 15),
                          _NumberInput(
                            label: "Comensales (capacidad)",
                            value: config.terraceCapacity,
                            icon: Icons.person_outline,
                            iconColor: AppColor.darkPink,
                            onChanged: (val) {
                              final newConfig =
                                  config.copyWith(terraceCapacity: val);
                              final totalCapacity = newConfig.interiorCapacity +
                                  newConfig.terraceCapacity;
                              context.read<ProfileBloc>().add(UpdateVenueConfig(
                                  newConfig.copyWith(
                                      totalCapacity: totalCapacity)));
                            },
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("Error loading config"));
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    this.iconColor = const Color(0xFF540BA8),
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 15),
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
          ...children,
        ],
      ),
    );
  }
}

class _NumberInput extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final IconData icon;
  final Color iconColor;

  const _NumberInput({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(Icons.table_bar, color: Colors.grey, size: 20),
        // const SizedBox(width: 15),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value.toString())
                    ..selection = TextSelection.fromPosition(
                        TextPosition(offset: value.toString().length)),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      onChanged(int.tryParse(val) ?? 0);
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
