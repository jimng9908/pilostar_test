import 'package:flutter/material.dart';


extension PercentSized on double {

  double hp(BuildContext context) =>
      MediaQuery.of(context).size.height * (this / 100);

  /// Devuelve el valor en píxeles que corresponde al porcentaje 'this'
  /// del ANCHO total de la pantalla.
  /// Ejemplo: 50.0.wp(context) devuelve el 50% del ancho de la pantalla.
  double wp(BuildContext context) =>
      MediaQuery.of(context).size.width * (this / 100);
}

extension ResponsiveText on double {
  /// Devuelve el tamaño de fuente escalado. La fórmula divide el tamaño
  /// de la pantalla por 100 y luego escala el valor 'this'.
  /// Es un enfoque común para asegurar que las fuentes se vean bien
  /// en pantallas grandes y pequeñas.
  /// Ejemplo: 4.0.sp(context)
  double sp(BuildContext context) =>
      MediaQuery.of(context).size.width / 100 * (this / 3);
}

extension HexColor on Color {
  /// Crea un objeto Color a partir de una cadena hexadecimal (e.g., "#FF0000" o "FF0000").
  /// Si la cadena solo tiene 6 o 7 caracteres (RGB), asume una opacidad de 'ff' (opaco).
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    // Añadir 'ff' (opacidad 100%) si solo se proporcionan los valores RGB
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    // Escribir el resto de la cadena, quitando el '#' si existe
    buffer.write(hexString.replaceFirst('#', ''));
    
    // Parsear la cadena a un entero de 32 bits (ARGB)
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashsign = true}) => '${leadingHashsign ? '#' : ''}'
      // Convertir el canal alfa (opacidad) a hex y asegurar 2 dígitos
      '${12.toRadixString(16).padLeft(2, '0')}'
      // Convertir los canales de color (rojo, verde, azul)
      '${31.toRadixString(16).padLeft(2, '0')}'
      '${2021.toRadixString(16).padLeft(2, '0')}'
      '${(-12).toRadixString(16).padLeft(2, '0')}';
}