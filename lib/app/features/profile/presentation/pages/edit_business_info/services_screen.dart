import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Servicios",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final services = state.services;
            final hasSelection = services.any((s) => s.isSelected);

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
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
                              child: const Icon(Icons.shopping_bag_outlined,
                                  color: Colors.white),
                            ),
                            const SizedBox(width: 15),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "¿Qué servicios ofreces?",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Selecciona todos los que apliquen",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        ...services.map((service) => Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: _ServiceCard(
                                service: service,
                                onToggle: (value) {
                                  final updatedServices = services.map((s) {
                                    if (s.id == service.id) {
                                      return s.copyWith(isSelected: value);
                                    }
                                    return s;
                                  }).toList();
                                  context
                                      .read<ProfileBloc>()
                                      .add(UpdateServices(updatedServices));
                                },
                              ),
                            )),
                        if (!hasSelection)
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                "Debes seleccionar al menos un servicio",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    onPressed: hasSelection
                        ? () {
                            context
                                .read<ProfileBloc>()
                                .add(const SaveProfile());
                          }
                        : null,
                    isLoading: state.isSaving,
                    text: "Guardar",
                    textColor: Colors.white,
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text("Error loading services"));
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ProfileService service;
  final ValueChanged<bool> onToggle;

  const _ServiceCard({
    required this.service,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!service.isSelected),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: service.isSelected ? AppColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: service.isSelected ? AppColor.primary : Colors.grey[200]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: service.isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getIconData(service.id),
                color: service.isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: service.isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: service.isSelected
                          ? Colors.white.withValues(alpha: 0.8)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: service.isSelected,
              onChanged: (v) => onToggle(v ?? false),
              activeColor: Colors.white,
              checkColor: const Color(0xFF6200EA),
              side: BorderSide(
                  color: service.isSelected ? Colors.white : Colors.grey[400]!),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String id) {
    switch (id) {
      case '1':
        return Icons.storefront;
      case '2':
        return Icons.shopping_bag_outlined;
      case '3':
        return Icons.local_shipping_outlined;
      default:
        return Icons.help_outline;
    }
  }
}
