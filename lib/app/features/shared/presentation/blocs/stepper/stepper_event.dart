part of 'stepper_bloc.dart';

abstract class StepperEvent {}

class NextStep extends StepperEvent {}

class PreviousStep extends StepperEvent {}

class StepTapped extends StepperEvent {
  final int index;
  StepTapped(this.index);
}

class UpdateTotalSteps extends StepperEvent {
  final int totalSteps;
  UpdateTotalSteps(this.totalSteps);
}
