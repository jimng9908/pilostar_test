part of 'stepper_bloc.dart';

class StepperState extends Equatable {
  final int currentStep;
  final int totalSteps;
  final bool isForward;

  const StepperState({
    this.currentStep = 0,
    required this.totalSteps,
    this.isForward = true,
  });

  StepperState copyWith({
    int? currentStep,
    int? totalSteps,
    bool? isForward,
  }) {
    return StepperState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      isForward: isForward ?? this.isForward,
    );
  }

  double get progress => (currentStep + 1) / totalSteps;

  @override
  List<Object?> get props => [currentStep, totalSteps, isForward];
}
