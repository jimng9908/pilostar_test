import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_event.dart';
part 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final int maxSteps;
  late final List<GlobalKey<FormState>> formKeys;

  StepperBloc({required this.maxSteps})
      : formKeys = List.generate(maxSteps, (_) => GlobalKey<FormState>()),
        super(StepperState(totalSteps: maxSteps)) {
    on<NextStep>((event, emit) {
      if (state.currentStep < maxSteps - 1) {
        emit(state.copyWith(
          currentStep: state.currentStep + 1,
          isForward: true,
        ));
      }
    });

    on<PreviousStep>((event, emit) {
      if (state.currentStep > 0) {
        emit(state.copyWith(
          currentStep: state.currentStep - 1,
          isForward: false,
        ));
      }
    });

    on<StepTapped>((event, emit) {
      if (state.currentStep != event.index) {
        emit(state.copyWith(
          currentStep: event.index,
          isForward: event.index > state.currentStep,
        ));
      }
    });

    on<UpdateTotalSteps>((event, emit) {
      emit(state.copyWith(totalSteps: event.totalSteps));
    });
  }
}
