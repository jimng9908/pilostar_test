import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class AnimatedStepProgress extends StatelessWidget {
  final List<String> steps;

  const AnimatedStepProgress({
    super.key,
    this.steps = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperBloc, StepperState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep ||
          previous.totalSteps != current.totalSteps,
      builder: (context, state) {
        final int currentStep = state.currentStep;
        final int totalSteps = state.totalSteps;
        final double progress = (currentStep + 1) / totalSteps;

        // Get step name if available
        final String stepName = (steps.isNotEmpty && currentStep < steps.length)
            ? steps[currentStep]
            : '';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Paso ${currentStep + 1} de $totalSteps",
                style: TextStyle(
                  color: const Color(0xFF495565),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  letterSpacing: -0.15,
                ),
              ),
              const SizedBox(height: 8),
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  tween: Tween<double>(begin: 0, end: progress),
                  builder: (context, value, _) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
                      backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.primary),
                    );
                  },
                ),
              ),
              if (stepName.isNotEmpty) ...[
                const SizedBox(height: 8),
                // Step Name
                Text(
                  stepName,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
