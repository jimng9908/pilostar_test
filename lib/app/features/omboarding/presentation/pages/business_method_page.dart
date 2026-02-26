import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/presentation/presentation.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/presentation/widgets/base_page.dart';
import 'package:rockstardata_apk/app/injection.dart';

class BusinessMethodPage extends StatelessWidget {
  const BusinessMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BusinessOnboardingBloc>(),
      child: BasePage(
        appBar: OmboardingAppBar(
          showBackButton: false,
          isRootPage: true,
        ),
        showAppBar: true,
        backgroundColor: AppColor.white,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (isUnauthenticated(state)) {
              context.go('/login');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 8.0.hp(context)),
                child: Column(
                  spacing: 10,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: AppColor.primary.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:
                                const Color(0xFF540BA8) /* Brand-Primary-800 */,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 13,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF540BA8),
                                size: 24,
                              ),
                              Text(
                                'Configuración de un local',
                                style: TextStyle(
                                  color: const Color(0xFF540BA8),
                                  fontSize: 16,
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w500,
                                  height: 1.50,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Por el momento puedes configurar un local. En futuras versiones podrás añadir hasta 2 locales como máximo.',
                            style: TextStyle(
                              color: const Color(0xCC560AAC),
                              fontSize: 14,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    MethodCard(
                      title: 'Configuración Automática',
                      description:
                          'Importa tus datos desde Google Maps automáticamente. ¡Rápido y sencillo!',
                      timeEstimate: '5 minutos',
                      image: 'assets/icons/automatic_flow_icon.png',
                      isRecommended: true,
                      onTap: () => context.push(
                          '/business_omboarding/google_import?method=automatic'),
                    ),
                    MethodCard(
                      title: 'Configuración Manual',
                      description:
                          'Configura cada detalle de tu negocio paso a paso. Control total sobre tus datos.',
                      timeEstimate: '10 minutos',
                      image: 'assets/icons/manual_flow_icon.png',
                      iconGradient: const [
                        Color(0xFF455A64),
                        Color(0xFF263238)
                      ],
                      onTap: () => context.push(
                          '/business_omboarding/google_import?method=manual'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Podrás modificar estos datos en cualquier momento',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
