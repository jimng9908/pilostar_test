import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class CancelationFlowSheet extends StatelessWidget {
  const CancelationFlowSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileLoaded) return const SizedBox.shrink();

        // Selector de pantallas según el paso actual
        Widget currentScreen;
        switch (state.cancellationStep) {
          case 0:
            currentScreen = const ReasonsStep();
            break;
          case 1:
            currentScreen = const OfferStep();
            break;
          case 2:
            currentScreen = const FinalConfirmationStep();
            break;
          case 3:
            currentScreen = const SuccessStep();
            break;
          default:
            currentScreen = const ReasonsStep();
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: currentScreen,
        );
      },
    );
  }
}