import 'package:flutter/material.dart';

class AemetFooter extends StatelessWidget {
  const AemetFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBBDEFB)),
      ),
      child: const Column(
        children: [
          Text(
            "Datos proporcionados por AEMET",
            style: TextStyle(
                color: Color(0xFF1976D2),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "(Agencia Estatal de Meteorología)",
            style: TextStyle(
                color: Color(0xFF1976D2),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            "Actualizado cada hora",
            style: TextStyle(color: Color(0xFF1E88E5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
