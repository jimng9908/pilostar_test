import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class RestartSubscription extends StatelessWidget {
  const RestartSubscription({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String day = now.day.toString();
    final int month = now.month;
    final String year = now.year.toString();
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) {
        if (previous is ProfileLoaded && current is ProfileLoaded) {
          return current.isRestartingSubscription == false &&
              previous.isRestartingSubscription == true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          bool isRestartingSubscription = false;
          if (state is ProfileLoaded) {
            isRestartingSubscription = state.isRestartingSubscription;
          }
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reactivar Plan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 1.30,
                        letterSpacing: -0.59,
                      ),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.black, size: 24)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 85,
                  height: 85,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: Icon(Icons.favorite_border_outlined,
                            color: AppColor.primary, size: 40),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    Text(
                      '¿Estás seguro de que quieres reactivar tu plan Started?\n Tu plan se reactivará el:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF6B6B6B),
                        fontSize: 17,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: -0.43,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$day de ${_getMotnh(month)} de $year',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF6B6B6B),
                        fontSize: 17,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                        letterSpacing: -0.43,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                CustomButton(
                  onPressed: !isRestartingSubscription
                      ? () {
                          context
                              .read<ProfileBloc>()
                              .add(RestartSubscriptionEvent());
                        }
                      : null,
                  text: 'Reactivar',
                  textColor: AppColor.white,
                  isLoading: isRestartingSubscription,
                ),
                const SizedBox(height: 8),
                CustomButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Cancelar',
                  backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
                  textColor: AppColor.primaryLight,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

_getMotnh(int month) {
  switch (month) {
    case 1:
      return 'enero';
    case 2:
      return 'febrero';
    case 3:
      return 'marzo';
    case 4:
      return 'abril';
    case 5:
      return 'mayo';
    case 6:
      return 'junio';
    case 7:
      return 'julio';
    case 8:
      return 'agosto';
    case 9:
      return 'septiembre';
    case 10:
      return 'octubre';
    case 11:
      return 'noviembre';
    case 12:
      return 'diciembre';
    default:
      return 'mes';
  }
}
