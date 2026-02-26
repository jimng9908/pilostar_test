import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ManualFormData extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController websiteController;
  final TextEditingController cifController;
  final TextEditingController municipioController;
  final ValueNotifier<Municipality?> selectedMunicipality;

  ManualFormData({
    super.key,
    required this.formKey,
    String? initialName,
    String? initialAddress,
    String? initialPhone,
    String? initialEmail,
    String? initialCif,
    String? initialWebsite,
    String? initialZoneCode,
    Municipality? initialMunicipio,
  })  : nameController = TextEditingController(text: initialName),
        addressController = TextEditingController(text: initialAddress),
        phoneController = TextEditingController(text: initialPhone),
        emailController = TextEditingController(text: initialEmail),
        websiteController = TextEditingController(text: initialWebsite),
        cifController = TextEditingController(text: initialCif),
        municipioController =
            TextEditingController(text: initialMunicipio?.displayName ?? ''),
        selectedMunicipality = ValueNotifier<Municipality?>(initialMunicipio) {
    // Si hay un municipio inicial, asegurar que el texto coincida
    if (initialMunicipio != null && municipioController.text.isEmpty) {
      municipioController.text = initialMunicipio.displayName;
    }

    // Escuchar cambios en el controller
    municipioController.addListener(_onMunicipioTextChanged);
  }

  void _onMunicipioTextChanged() {
    if (municipioController.text.isEmpty) {
      selectedMunicipality.value = null;
    }
  }

  void dispose() {
    municipioController.removeListener(_onMunicipioTextChanged);
    // No disponer los controllers aquí porque los maneja el padre
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(overscroll: false),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Datos de tu negocio',
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.56,
                        letterSpacing: -0.44,
                      ),
                    ),
                    Text(
                      'Completa la información básica de tu establecimiento',
                      style: TextStyle(
                        color: AppColor.grey,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.57,
                        letterSpacing: -0.28,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildTextField(
                      label: 'Nombre del negocio',
                      controller: nameController,
                      hint: 'Nombre del negocio',
                      validator: FormValidator.requiredValidator,
                      isRequired: true,
                    ),
                    _buildTextField(
                      label: 'Dirección completa',
                      controller: addressController,
                      hint: 'Dirección completa',
                      validator: FormValidator.validateAddress,
                      isRequired: true,
                    ),
                    _buildTextField(
                      label: 'Teléfono',
                      controller: phoneController,
                      hint: 'Teléfono',
                      keyboardType: TextInputType.phone,
                      inputFormatters: [InternationalPhoneFormatter()],
                    ),
                    _buildTextField(
                      label: 'Email',
                      controller: emailController,
                      hint: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: FormValidator.validateEmail,
                      isRequired: true,
                    ),
                    _buildTextField(
                      label: 'Sitio web',
                      controller: websiteController,
                      hint: 'Sitio web',
                      keyboardType: TextInputType.url,
                      validator: FormValidator.validateUrl,
                    ),
                    _buildMunicipioField(controller: municipioController),
                    _buildTextField(
                      label: 'CIF/NIF',
                      controller: cifController,
                      hint: 'CIF/NIF',
                      validator: FormValidator.validateNifCif,
                      isRequired: true,
                      inputFormatters: [NIFFormatter()],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListenableBuilder(
              listenable: Listenable.merge([
                nameController,
                addressController,
                emailController,
                cifController,
                selectedMunicipality,
              ]),
              builder: (context, _) {
                final bool isFormPopulated = nameController.text.isNotEmpty &&
                    addressController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    cifController.text.isNotEmpty &&
                    selectedMunicipality.value != null;

                return CustomButton(
                  onPressed:
                      isFormPopulated ? () => _handleNext(context) : null,
                  text: 'Siguiente',
                  textColor: AppColor.white,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _handleNext(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<BusinessOnboardingBloc>().add(
            SubmitManualData(
              name: nameController.text,
              address: addressController.text,
              phone: phoneController.text,
              email: emailController.text,
              cif: cifController.text,
              website: websiteController.text,
              zoneCode: selectedMunicipality.value?.zoneCode,
              municipalityCode: selectedMunicipality.value?.municipalityCode,
              selectedMunicipality: selectedMunicipality.value,
            ),
          );
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColor.grey,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.57,
            letterSpacing: -0.28,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }

  Widget _buildMunicipioField({
    required TextEditingController controller,
  }) {
    final focusNode = FocusNode();
    final showSuggestions = ValueNotifier<bool>(false);
    final searchText =
        ValueNotifier<String>(''); // ValueNotifier para el texto de búsqueda

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<Municipality?>(
            valueListenable: selectedMunicipality,
            builder: (context, selected, child) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: 'Municipio *',
                  hintText: 'Selecciona un municipio',
                  hintStyle: TextStyle(
                    color: AppColor.grey,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.57,
                    letterSpacing: -0.28,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: municipioController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () {
                            municipioController.clear();
                            searchText.value =
                                ''; // Actualizar el ValueNotifier
                            selectedMunicipality.value = null;
                            showSuggestions.value = false;
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  // Actualizar el ValueNotifier cuando el texto cambia
                  searchText.value = value;
                  showSuggestions.value =
                      focusNode.hasFocus && value.isNotEmpty;
                  if (selected != null && selected.displayName != value) {
                    selectedMunicipality.value = null;
                  }
                },
                onTap: () {
                  if (municipioController.text.isNotEmpty) {
                    showSuggestions.value = true;
                  }
                },
                onFieldSubmitted: (_) {
                  showSuggestions.value = false;
                },
                validator: (value) {
                  if (selectedMunicipality.value == null) {
                    return 'Debes seleccionar un municipio';
                  }
                  return null;
                },
              );
            },
          ),

          // Usar ValueListenableBuilder para escuchar los cambios en searchText
          ValueListenableBuilder<bool>(
            valueListenable: showSuggestions,
            builder: (context, show, child) {
              if (!show) return const SizedBox.shrink();

              return ValueListenableBuilder<String>(
                valueListenable: searchText, // Escuchar cambios en el texto
                builder: (context, query, child) {
                  // Filtrar municipios con el texto actual
                  final filteredList = _filterMunicipalities(query);

                  if (filteredList.isEmpty) return const SizedBox.shrink();

                  return Container(
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final municipio = filteredList[index];

                        return ValueListenableBuilder<Municipality?>(
                          valueListenable: selectedMunicipality,
                          builder: (context, selected, child) {
                            final isSelected = selected == municipio;

                            return ListTile(
                              title: Text(
                                municipio.displayName,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : null,
                                ),
                              ),
                              subtitle: Text(
                                'Provincia: ${municipio.provinceName}',
                              ),
                              tileColor:
                                  isSelected ? Colors.grey.shade100 : null,
                              onTap: () {
                                municipioController.text =
                                    municipio.displayName;
                                searchText.value = municipio
                                    .displayName; // Actualizar searchText
                                selectedMunicipality.value = municipio;
                                showSuggestions.value = false;
                                focusNode.unfocus();
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  List<Municipality> _filterMunicipalities(String query) {
    if (query.isEmpty) return [];

    final cleanQuery = query.toLowerCase().trim();

    final filtered = Municipality.values.where((municipio) {
      final displayName = municipio.displayName.toLowerCase();
      return displayName.startsWith(cleanQuery);
    }).toList();

    // Limitar a 10 resultados
    if (filtered.length > 10) {
      return filtered.sublist(0, 10);
    }
    return filtered;
  }
}
