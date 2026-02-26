import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class SuccessStep extends StatelessWidget {
  const SuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String day = now.day.toString();
    final int month = now.month;
    final String year = now.year.toString();
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
                'Suscripción Cancelada',
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
                  child: Icon(Icons.check,
                      color: AppColor.black.withValues(alpha: 0.5), size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              Text(
                'Lamentamos verte partir. \nTu plan seguirá activo hasta el',
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
            onPressed: () => Navigator.pop(context),
            text: '¡Esperamos verte de vuelta pronto!',
            textColor: AppColor.white,
          ),
        ],
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
