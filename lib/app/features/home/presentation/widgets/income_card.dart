import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';

class MainIncomeCard extends StatelessWidget {
  final double amount;
  final double percentage;
  final String filterType;
  final double goal;

  const MainIncomeCard({
    super.key,
    required this.amount,
    required this.percentage,
    required this.filterType,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final goalPorcentage =
        (amount / goal * 100).clamp(0, 100).toStringAsFixed(0);

    return Container(
      constraints: BoxConstraints(
        maxHeight: 21.0.hp(context),
        maxWidth: double.infinity,
      ),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.50, 0.00),
          end: Alignment(0.50, 1.00),
          colors: [Color(0xFF560BAD), Color(0xFF7F38A5)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          // Background decoration
          Positioned(
            right: -40,
            top: -10,
            child: Container(
              width: 145,
              height: 147,
              decoration: ShapeDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                shape: const CircleBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header Row: Icon and Label
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.20),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                                child: Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Colors.white)),
                          ),
                          Text(
                            'Ingresos de ${filterType.toLowerCase()}',
                            style: const TextStyle(
                              color: Color(0xE5FFFEFE),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 5,
                        children: [
                          _PercentageBadge(percentage: percentage),
                          Text(
                            'vs.',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 8.0.sp(context),
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            MapperPreviousDate.getVsText(filterType),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 8.0.sp(context),
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Data Group: Amount, Percentage, and Objective
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${NumberFormat.decimalPattern('es_ES').format(amount)} €',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            height: 1.30,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.0.hp(context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Objetivo: € ${NumberFormat.decimalPattern('es_ES').format(goal)}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 9.0.sp(context),
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                          ),
                        ),
                        Text(
                          '$goalPorcentage%',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12.0.sp(context),
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Progress Bar
                _ProgressBar(progress: (amount / goal).clamp(0.0, 1.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PercentageBadge extends StatelessWidget {
  final double percentage;
  const _PercentageBadge({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(percentage > 0 ? Icons.north_east : Icons.south_east,
              color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            '${percentage > 0 ? '+' : '-'}${percentage.toInt().abs().toString()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double progress;
  const _ProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6,
      decoration: BoxDecoration(
        color: const Color(0x33787878),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
