import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';

class OmboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // Para ocultarlo en BusinessMethodPage
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool isRootPage; // Para el estilo especial de la primera página

  const OmboardingAppBar({
    super.key,
    this.title = 'RockStar Data',
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.isRootPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
      builder: (context, state) {
        return AppBar(
          toolbarHeight: kToolbarHeight,
          backgroundColor: AppColor.primary.withValues(
              blue: 0.28, red: 0.15, green: 0.09), // Morado profundo del diseño
          elevation: 2,
          automaticallyImplyLeading:
              false, // Quitamos el botón por defecto de Flutter
          leading: showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    final currentState =
                        context.read<BusinessOnboardingBloc>().state;
                    if (currentState is BusinessOnboardingLoaded &&
                        currentState.step == OnboardingStep.googleIntro) {
                      Navigator.of(context).pop();
                    } else if (currentState is BusinessOnboardingLoaded &&
                        currentState.step == OnboardingStep.manualEntry &&
                        currentState.method == OnboardingMethod.manual) {
                      Navigator.of(context).pop();
                    } else {
                      if (onBackPressed != null) {
                        onBackPressed!();
                      } else {
                        context
                            .read<BusinessOnboardingBloc>()
                            .add(BackToPrevious());
                      }
                    }
                  },
                )
              : null,
          titleSpacing:
              showBackButton ? 0 : 20, // Ajuste de margen si no hay flecha
          title: SizedBox(
            height: kToolbarHeight * 0.7,
            child: Image.asset(
              'assets/images/pilotstar_logo_4.png',
              fit: BoxFit.contain,
            ),
          ),
          bottom: isRootPage
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(84),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: showBackButton ? 56 : 20,
                      bottom: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¿Cómo quieres empezar?',
                          style: TextStyle(
                            color: Color(0xFFF2F1F4),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 1.56,
                            letterSpacing: -0.44,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Elige el método de configuración que prefieras',
                          style: TextStyle(
                            color: Color(0xCCF2F0F3),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: -0.15,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : null,
          actions: actions ??
              [
                PopupMenuButton<String>(
                  offset: const Offset(0, 50),
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll<Color>(Colors.transparent),
                  ),
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'logout') {
                      context.read<AuthBloc>().add(LogoutRequested());
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Cerrar sesión'),
                    ),
                  ],
                ),
              ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isRootPage ? 120 : kToolbarHeight);
}
