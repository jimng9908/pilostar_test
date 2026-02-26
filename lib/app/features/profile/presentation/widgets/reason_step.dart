import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';
// Asegúrate de importar tu bloc y eventos correctamente
// import 'package:rockstardata_apk/app/features/profile/index.dart';

class ReasonsStep extends StatelessWidget {
  const ReasonsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // Obtenemos los valores actuales del estado del Bloc
        final String? selectedReason =
            (state is ProfileLoaded) ? state.cancelReason : null;
        final bool isSaving = (state is ProfileLoaded) ? state.isSaving : false;

        final List<Map<String, dynamic>> reasons = [
          {'label': 'Es demasiado caro', 'icon': Icons.euro_symbol},
          {'label': 'No lo uso suficiente', 'icon': Icons.pause_circle_outline},
          {
            'label': 'No cumple mis expectativas',
            'icon': Icons.thumb_down_outlined
          },
          {'label': 'Cambio a otro servicio', 'icon': Icons.info_outline},
          {'label': 'Cierro mi negocio', 'icon': Icons.warning_amber_rounded},
          {'label': 'Otra razón', 'icon': Icons.info_outline},
        ];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              overscroll: false,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '¿Por qué nos dejas?',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tu opinión es muy importante para nosotros. Selecciona la razón principal de tu cancelación:',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 24),

                  // Lista de motivos conectada al Bloc
                  ...reasons.map((reason) {
                    final bool isSelected = selectedReason == reason['label'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          // Enviamos el evento al Bloc al seleccionar
                          context
                              .read<ProfileBloc>()
                              .add(UpdateCancelReason(reason['label']));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Colors.deepPurple
                                  : Colors.grey.shade200,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(reason['icon'],
                                        color: Colors.grey, size: 20),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    reason['label'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              if (isSelected)
                                Icon(Icons.check_rounded,
                                    color: AppColor.primary),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  if (selectedReason == 'Otra razón') ...[
                    const SizedBox(height: 16),
                    const Text(
                      '¿Algo más que quieras contarnos? (opcional)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 12),

                    // TextField para el feedback conectado al Bloc
                    TextField(
                      maxLines: 4,
                      onChanged: (value) {
                        context
                            .read<ProfileBloc>()
                            .add(UpdateCancelFeedback(value)); //
                      },
                      decoration: InputDecoration(
                        hintText: 'Tu feedback nos ayuda a mejorar...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Botones de acción finales
                  CustomButton(
                    text: 'Cancelar suscripción',
                    textColor: AppColor.white,
                    onPressed: (selectedReason != null && !isSaving)
                        ? () => context
                            .read<ProfileBloc>()
                            .add(NextCancellationStep()) //
                        : null,
                    isLoading: isSaving,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Cancelar',
                    textColor: AppColor.primaryLight,
                    backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
