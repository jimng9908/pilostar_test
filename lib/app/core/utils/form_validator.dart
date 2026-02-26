import 'package:flutter/services.dart';

class FormValidator {
  // 1. Full Name (Al menos dos palabras)
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) return 'El nombre es obligatorio';
    if (value.trim().split(' ').length < 2) return 'Ingresa nombre y apellido';
    return null;
  }

  // 2. Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'El correo es obligatorio';
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) return 'Correo inválido';
    return null;
  }

  // 3. Password (Mínimo 8 caracteres, una mayúscula y un número)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa una contraseña valida';
    }
    if (value.length < 8) {
      return 'La contraseña debe contener al\nmenos 8 caracteres';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'La contraseña debe contener al\nmenos una letra mayúscula';
    }
    if (!value.contains(RegExp(r'[!#$%^&*(),.?":{}|<>]'))) {
      return 'La contraseña debe contener al\nmenos un carácter especial';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'La contraseña debe contener al\nmenos un número';
    }
    return null;
  }

  // 4. URL
  static String? validateUrl(String? value) {
    final urlRegExp = RegExp(
        r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//!=,]*)$');
    if (value != null && value.isNotEmpty) {
      if (!urlRegExp.hasMatch(value)) {
        return 'URL inválida';
      }
    }
    return null;
  }

  // 5. Phone Number (Básico internacional)
  static String? validatePhoneNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      final phoneRegExp = RegExp(r'^\+?[0-9]{9,15}$');

      if (!phoneRegExp.hasMatch(value)) {
        return 'Teléfono inválido';
      }
    }
    return null;
  }

  // 6. Dirección
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) return 'La dirección es obligatoria';
    if (value.length < 10) return 'La dirección es demasiado corta';
    return null;
  }

  // 7. NIF / CIF (España)
  static String? validateNifCif(String? value) {
    if (value == null || value.isEmpty) return 'Documento obligatorio';
    final nifRegExp = RegExp(r'^[0-9]{8}[a-zA-Z]$');
    if (!nifRegExp.hasMatch(value.toUpperCase())) return 'NIF/CIF inválido';
    return null;
  }

  // 8. Bearer Token
  static String? validateBearerToken(String? value) {
    if (value == null || value.isEmpty) return 'Token obligatorio';
    final tokenRegExp =
        RegExp(r'^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]*$');
    if (!tokenRegExp.hasMatch(value)) return 'Token inválido';
    return null;
  }

  // 9. API Key
  static String? validateApiKey(String? value) {
    if (value == null || value.isEmpty) return 'API Key obligatoria';
    final apiRegExp = RegExp(r'^([a-z]{2,4}[_-])?[A-Za-z0-9]{20,60}$');
    if (!apiRegExp.hasMatch(value)) return 'API Key inválido';
    return null;
  }

  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) return 'Código postal obligatorio';
    final zipCodeRegExp = RegExp(r'^[0-9]{5}$');
    if (!zipCodeRegExp.hasMatch(value)) return 'Código postal inválido';
    return null;
  }

  static String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  // 10. Mask Email (ej: us***@example.com)
  static String maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return email;
    final parts = email.split('@');
    final user = parts[0];
    final domain = parts[1];
    if (user.length <= 2) {
      return '${user.substring(0, 1)}***@$domain';
    }
    return '${user.substring(0, 2)}***@$domain';
  }
}

class InternationalPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // Obtener solo los dígitos (quitando el + y espacios previos si los hay)
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      if (newValue.text.contains('+')) {
        return const TextEditingValue(
          text: '+',
          selection: TextSelection.collapsed(offset: 1),
        );
      }
      return newValue;
    }

    // Limitar a 15 dígitos según estándar E.164
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    // Formatear: +XX XXX XXX XXX...
    String formatted = '+';
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (i == 2 || i == 5 || i == 8 || i == 11 || i == 14)) {
        formatted += ' ';
      }
      formatted += digits[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class NIFFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    String formatted = '';
    for (int i = 0; i < newValue.text.length; i++) {
      // 1. Limitar a 9 caracteres máximo
      if (i >= 9) break;

      if (i < 8) {
        // 2. Para las primeras 8 posiciones: Solo permitir números
        if (RegExp(r'[0-9]').hasMatch(newValue.text[i])) {
          formatted += newValue.text[i];
        }
      } else {
        // 3. Para la posición 9 (índice 8): Solo permitir letras
        if (RegExp(r'[A-Za-z]').hasMatch(newValue.text[i])) {
          formatted += newValue.text[i];
        }
      }
    }

    if (formatted.length > 9) {
      formatted = formatted.substring(0, 9);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class ZipCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    String formatted = '';
    for (int i = 0; i < newValue.text.length; i++) {
      if (i >= 5) break;

      if (i < 5) {
        if (RegExp(r'[0-9]').hasMatch(newValue.text[i])) {
          formatted += newValue.text[i];
        }
      }
    }

    if (formatted.length > 5) {
      formatted = formatted.substring(0, 5);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
