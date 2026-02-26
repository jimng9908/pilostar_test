import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String text;

  const InfoBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF2FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD0E2FF), width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4A7BCC),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}