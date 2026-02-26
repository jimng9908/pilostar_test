import 'dart:convert';
import 'package:flutter/foundation.dart';

class JwtDecoder {

  static Map<String, dynamic> decode(String token) {
    final parts = token.split('.');
    
    if (parts.length != 3) {
      throw const FormatException('El formato del JWT no es válido (debe tener 3 partes separadas por puntos).');
    }

    final payload = parts[1];

    final String decoded = _decodeBase64(payload);

    final Map<String, dynamic> payloadMap = json.decode(decoded);

    return payloadMap;
  }


  static bool isExpired(String token) {
    try {
      final Map<String, dynamic> payload = decode(token);
      
      if (!payload.containsKey('exp')) {
        if (kDebugMode) {
          debugPrint('El token no contiene el claim "exp".');
        }
        return false;
      }
      
      final int expirationTimestamp = payload['exp'] as int;
      
      final DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(
        expirationTimestamp * 1000, 
      );

      return DateTime.now().isAfter(expirationDate);
      
    } on FormatException catch (e) {
      if (kDebugMode) {
        debugPrint('Error de formato al decodificar o verificar expiración: $e');
      }
      return true; 
    }
  }
  
  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw const FormatException('Base64Url de Payload inválido');
    }

    return utf8.decode(base64Url.decode(output));
  }
}