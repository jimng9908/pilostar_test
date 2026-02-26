import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
          "Mi Perfil",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final info = state.profileInfo;
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                overscroll: false,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Center Avatar
                    Container(
                      width: double.infinity,
                      color: AppColor.white,
                      child: Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 25.0.wp(context),
                                  height: 25.0.wp(context),
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
                                  child: const Icon(Icons.person_outline,
                                      color: Colors.white, size: 40),
                                ),
                                Positioned(
                                  bottom: -1,
                                  right: -1,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.camera_alt,
                                        color: Colors.white, size: 18),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              info.name.isNotEmpty ? info.name : "Usuario",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Propietario",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            CustomButton(
                              width: 35.0.wp(context),
                              onPressed: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(const ToggleEditProfile());
                              },
                              icon: state.isEditingProfile
                                  ? Icons.close
                                  : Icons.edit_outlined,
                              text: state.isEditingProfile
                                  ? "Cancelar"
                                  : "Editar Perfil",
                              textColor: AppColor.white,
                              backgroundColor: state.isEditingProfile
                                  ? Colors.grey[400]
                                  : AppColor.primary,
                              isLoading: false,
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Información Personal
                    _buildSectionHeader("Información Personal"),
                    const SizedBox(height: 12),
                    _ReadOnlyInfoCard(
                      items: [
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.person_outline,
                          label: "Nombre completo",
                          value: info.name,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(
                                UpdateProfileInfo(info.copyWith(name: val)));
                          },
                        ),
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.email_outlined,
                          label: "Email",
                          value: info.email,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(
                                UpdateProfileInfo(info.copyWith(email: val)));
                          },
                        ),
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.phone_outlined,
                          label: "Teléfono",
                          value: info.phone,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(
                                UpdateProfileInfo(info.copyWith(phone: val)));
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Información del Negocio
                    _buildSectionHeader("Información del Negocio"),
                    const SizedBox(height: 12),
                    _ReadOnlyInfoCard(
                      items: [
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.store_outlined,
                          label: "Nombre del negocio",
                          value: info.businessName,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(UpdateProfileInfo(
                                info.copyWith(businessName: val)));
                          },
                        ),
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.location_on_outlined,
                          label: "Dirección",
                          value: info.businessAddress,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(UpdateProfileInfo(
                                info.copyWith(businessAddress: val)));
                          },
                        ),
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.storefront_outlined,
                          label: "Tipo de negocio",
                          value: info.businessType,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(UpdateProfileInfo(
                                info.copyWith(businessType: val)));
                          },
                        ),
                        _ReadOnlyInfoItem(
                          isEditing: state.isEditingProfile,
                          icon: Icons.badge_outlined,
                          label: "NIF/CIF",
                          value: info.nifCif,
                          onChanged: (val) {
                            context.read<ProfileBloc>().add(
                                UpdateProfileInfo(info.copyWith(nifCif: val)));
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Tu Actividad
                    _buildSectionHeader("Tu Actividad"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: _buildActivityCard(
                                "127", "Días activo", const Color(0xFF540BA8))),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildActivityCard(
                                "5", "Fuentes", const Color(0xFFFF4081))),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _buildActivityCard(
                                "48", "Alertas", const Color(0xFF2979FF))),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Column(
                      children: [
                        CustomButton(
                            text: "Guardar",
                            onPressed: state.isEditingProfile
                                ? () {
                                    context
                                        .read<ProfileBloc>()
                                        .add(const SaveProfile());
                                    context.pop();
                                  }
                                : null,
                            backgroundColor: AppColor.primary,
                            textColor: Colors.white,
                            isLoading: state.isSaving),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: "Cancelar",
                          onPressed: () => context.pop(),
                          backgroundColor:
                              AppColor.greyDark.withValues(alpha: 0.3),
                          textColor: AppColor.primary,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("Error loading profile"));
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildActivityCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadOnlyInfoCard extends StatelessWidget {
  final List<_ReadOnlyInfoItem> items;

  const _ReadOnlyInfoCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final isLast = index == items.length - 1;
          return Column(
            children: [
              items[index],
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[100],
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _ReadOnlyInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isEditing;
  final ValueChanged<String>? onChanged;

  const _ReadOnlyInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isEditing = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                if (isEditing)
                  TextField(
                    controller: TextEditingController(text: value)
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: value.length),
                      ),
                    onChanged: onChanged,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  )
                else
                  Text(
                    value.isNotEmpty ? value : "Not set",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
