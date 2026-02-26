import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class ObjectivesGoals extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController ventasController;
  final TextEditingController clientesController;
  final TextEditingController ticketController;
  final TextEditingController platoController;
  final TextEditingController margenController;

  ObjectivesGoals({
    super.key,
    ResponseGoalsEntity? initialGoals,
  })  : ventasController =
            TextEditingController(text: initialGoals?.monthlySalesTarget ?? ''),
        clientesController = TextEditingController(
            text: initialGoals?.monthlyClientsTarget.toString() ?? '0'),
        ticketController = TextEditingController(
            text: initialGoals?.averageTicketTarget.toString() ?? '0'),
        platoController = TextEditingController(
            text: initialGoals?.averageMarginPerDishTarget.toString() ?? '0'),
        margenController = TextEditingController(
            text: initialGoals?.marginPercentageTarget.toString() ?? '0');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      buildWhen: (previous, current) {
        if (previous is BusinessOnboardingLoaded &&
            current is BusinessOnboardingLoaded) {
          return previous.fetchingData != current.fetchingData;
        }
        return true;
      },
      builder: (context, state) {
        final bool isLoading =
            state is BusinessOnboardingLoaded && state.fetchingData;

        return Form(
          key: formKey,
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(overscroll: false),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Objetivos y Metas',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Define tus objetivos para recibir alertas automáticas',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: AppColor.black.withValues(alpha: 0.5),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Goal Cards
                  GoalCard(
                    controller: ventasController,
                    title: 'Ventas mensuales',
                    subtitle: 'Objetivo mensual',
                    icon: Icons.attach_money,
                    currentValue: 4500,
                    unit: '€',
                    isSuggested: true,
                  ),
                  const SizedBox(height: 16),
                  GoalCard(
                    controller: clientesController,
                    title: 'Clientes mensuales',
                    subtitle: 'Objetivo mensual',
                    icon: Icons.people_outline,
                    currentValue: 1200,
                    unit: 'clientes',
                    isSuggested: true,
                  ),
                  const SizedBox(height: 16),
                  GoalCard(
                    controller: ticketController,
                    title: 'Ticket medio',
                    subtitle: 'Objetivo mensual',
                    icon: Icons.shopping_cart_outlined,
                    currentValue: 37.50,
                    unit: '€',
                    isSuggested: true,
                  ),
                  const SizedBox(height: 16),
                  GoalCard(
                    controller: platoController,
                    title: 'Margen promedio por plato',
                    subtitle: 'Objetivo mensual',
                    icon: Icons.trending_up,
                    currentValue: 12.80,
                    unit: '€',
                    isSuggested: true,
                  ),
                  const SizedBox(height: 16),
                  GoalCard(
                    controller: margenController,
                    title: 'Margen',
                    subtitle: 'Objetivo semanal',
                    icon: Icons.percent,
                    currentValue: 22,
                    unit: '%',
                    isSuggested: true,
                  ),
                  const SizedBox(height: 24),

                  // Footer
                  Column(
                    children: [
                      ListenableBuilder(
                        listenable: Listenable.merge([
                          ventasController,
                          clientesController,
                          ticketController,
                          platoController,
                          margenController,
                        ]),
                        builder: (context, _) {
                          final isPopulated =
                              ventasController.text.isNotEmpty &&
                                  clientesController.text.isNotEmpty &&
                                  ticketController.text.isNotEmpty &&
                                  platoController.text.isNotEmpty &&
                                  margenController.text.isNotEmpty;

                          return CustomButton(
                            onPressed: isPopulated && !isLoading
                                ? () => _handleNext(context)
                                : null,
                            text: 'Siguiente',
                            textColor: Colors.white,
                            isLoading: isLoading,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        onPressed: () {
                          context
                              .read<BusinessOnboardingBloc>()
                              .add(BackToPrevious());
                        },
                        text: 'Atrás',
                        backgroundColor:
                            AppColor.greyDark.withValues(alpha: 0.3),
                        textColor: AppColor.purple,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleNext(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<BusinessOnboardingBloc>().add(
            SubmitObjectives(
              monthlySalesTarget: double.tryParse(ventasController.text) ?? 0,
              monthlyClientsTarget: int.tryParse(clientesController.text) ?? 0,
              averageTicketTarget: double.tryParse(ticketController.text) ?? 0,
              averageMarginPerDishTarget:
                  double.tryParse(platoController.text) ?? 0,
              marginPercentageTarget:
                  double.tryParse(margenController.text) ?? 0,
            ),
          );
    }
  }
}
