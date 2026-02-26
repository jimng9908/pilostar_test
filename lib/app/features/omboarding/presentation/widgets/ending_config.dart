import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class EndingConfig extends StatelessWidget {
  const EndingConfig({super.key});

  static const List<String> _steps = [
    'Sincronizando fuentes de datos',
    'Validando Información',
    'Procesando métricas',
    'Generando KPI',
    '¡Todo listo!',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        final double progress =
            state is BusinessOnboardingLoaded ? state.progress : 0;
        final stepIndex =
            state is BusinessOnboardingLoaded ? state.stepIndex : 0;
        final isDone = state is BusinessOnboardingLoaded
            ? state.endingStepIndex == 5
            : false;
        return Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Preparando tus datos',
              style: TextStyle(
                color: const Color(0xFF1A171C),
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.33,
                letterSpacing: 0.07,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Estamos optimizando tu cuenta para ti',
              style: TextStyle(
                color: const Color(0xFF495565),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.43,
                letterSpacing: -0.15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0.hp(context)),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                final int animatedPercentage = (value * 100).toInt();
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 8,
                        backgroundColor: AppColor.grey.withValues(alpha: 0.3),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColor.primary),
                      ),
                    ),
                    Text(
                      '$animatedPercentage%',
                      style: TextStyle(
                        color: Colors.black /* Brand-Black */,
                        fontSize: 22,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w500,
                        height: 1.30,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10.0.hp(context)),
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(overscroll: false),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _steps.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final isCompleted = index < stepIndex;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.65,
                            color: const Color(0x4C560AAC),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: isCompleted
                                ? AppColor.primary
                                : AppColor.primary.withValues(alpha: 0.5),
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _steps[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: -0.43,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: CustomButton(
                text: "Siguiente",
                textColor: AppColor.white,
                onPressed: isDone
                    ? () {
                        context
                            .read<BusinessOnboardingBloc>()
                            .add(GoToKpiSelection());
                      }
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
