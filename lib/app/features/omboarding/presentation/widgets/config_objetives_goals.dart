import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class ConfigObjetivesGoals extends StatelessWidget {
  const ConfigObjetivesGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeaderBanner(),
            const SizedBox(height: 24),
            _buildInfoBanner(),
            const SizedBox(height: 24),
            _buildCards(
              context,
              icon: Icons.auto_awesome_outlined,
              iconColor: AppColor.primary,
              title: 'Continuar sin objetivos',
              isRecomended: true,
              description: Text(
                'Empieza a explorar tu dashboard ahora y configura tus objetivos más tarde con sugerencias personalizadas.',
                style: TextStyle(
                  color: const Color(0xFF6B6B6B),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: -0.23,
                ),
              ),
              onTap: () {
                context
                    .read<BusinessOnboardingBloc>()
                    .add(GoToConfigObjetivesGoals(isConfigNow: false));
              },
            ),
            const SizedBox(height: 24),
            _buildCards(
              context,
              icon: Icons.track_changes_outlined,
              iconColor: AppColor.primaryStrong,
              title: 'Configurar objetivos ahora',
              isRecomended: false,
              description: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    '¿Ya conoces tus objetivos?\n Configúralos manualmente.',
                    style: TextStyle(
                      color: const Color(0xFF6B6B6B),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.23,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColor.green,
                        size: 16,
                      ),
                      Text(
                        'Alertas automáticas activadas',
                        style: TextStyle(
                          color: const Color(0xFF6B6B6B),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                          letterSpacing: -0.23,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {
                context
                    .read<BusinessOnboardingBloc>()
                    .add(GoToConfigObjetivesGoals(isConfigNow: true));
              },
            ),
            const SizedBox(height: 24),
            _buildInfoFutterBanner(),
          ],
        ),
      ),
    );
  }

  _buildHeaderBanner() {
    return Column(
      children: [
        Text(
          'Calculando tus objetivos inteligentes',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF1A171C),
            fontSize: 22,
            fontFamily: 'SF Pro',
            fontWeight: FontWeight.w500,
            height: 1.30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Analizamos tu histórico para ofrecerte metas basadas en tu rendimiento real.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF4A5565),
            fontSize: 16,
            fontFamily: 'SF Pro',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.60),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0x339918DE),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(
                Icons.access_time_outlined,
                color: AppColor.primaryStrong,
              ),
              Text(
                'Tiempo estimado: 24-48 horas',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                  letterSpacing: -0.23,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Te avisaremos en cuanto tus sugerencias personalizadas estén listas en',
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                    letterSpacing: -0.23,
                  ),
                ),
                TextSpan(
                  text: ' MI Perfil.',
                  style: TextStyle(
                    color: AppColor.black.withValues(alpha: 0.6),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                    letterSpacing: -0.23,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCards(BuildContext context,
      {required IconData icon,
      required Color iconColor,
      required String title,
      required bool isRecomended,
      required Widget description,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: const Color(0xFFE0E0E0),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Icon(icon, color: iconColor),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: -0.43,
                          ),
                        ),
                        isRecomended
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Recomendado',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 1.50,
                                    letterSpacing: -0.23,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.primary,
                  size: 16,
                )
              ],
            ),
            description,
          ],
        ),
      ),
    );
  }

  _buildInfoFutterBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: AppColor.info.withValues(alpha: 0.10),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: AppColor.info,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Icon(Icons.info_outline, color: AppColor.info, size: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  SizedBox(
                    width: 260,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Consejo:',
                            style: TextStyle(
                              color: AppColor.infoDark,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.23,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Si esperas a las sugerencias inteligentes, tendrás objetivos optimizados basados en tu historial ',
                            style: TextStyle(
                              color: AppColor.infoDark,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: -0.23,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
