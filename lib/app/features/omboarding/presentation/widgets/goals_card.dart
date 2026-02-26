import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockstardata_apk/app/core/core.dart';

class GoalCard extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String subtitle;
  final IconData icon;
  final num currentValue;
  final String unit;
  final bool isSuggested;
  final double criticalThreshold;
  final double alertThreshold;

  const GoalCard({
    super.key,
    required this.controller,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.currentValue,
    required this.unit,
    this.isSuggested = false,
    this.criticalThreshold = 20.0,
    this.alertThreshold = 11.0,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Card(
          elevation: 1,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Icon(icon, color: AppColor.primary, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.30,
                              letterSpacing: -0.60,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: const Color(0xFF6B6B6B),
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.47,
                              letterSpacing: -0.21,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Input Section
                Text(
                  'Define tu objetivo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                    letterSpacing: -0.23,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    suffixText: ' $unit',
                    suffixStyle: GoogleFonts.outfit(
                      color: AppColor.black.withValues(alpha: 0.5),
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6B38FB)),
                    ),
                  ),
                  validator: FormValidator.requiredValidator,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
