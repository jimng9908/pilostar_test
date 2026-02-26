import 'package:flutter_test/flutter_test.dart';
import 'package:rockstardata_apk/app/core/utils/form_validator.dart';

void main() {
  group('FormValidator - validatePhoneNumber', () {
    test('should return null for valid international numbers with +', () {
      expect(FormValidator.validatePhoneNumber('+34600000000'), null);
      expect(FormValidator.validatePhoneNumber('+12025550123'), null);
      expect(FormValidator.validatePhoneNumber('+442071234567'), null);
      expect(FormValidator.validatePhoneNumber('+8613800138000'), null);
    });

    test('should return null for valid numbers without +', () {
      expect(FormValidator.validatePhoneNumber('34600000000'), null);
      expect(FormValidator.validatePhoneNumber('12025550123'), null);
      expect(FormValidator.validatePhoneNumber('600123456'), null);
    });

    test('should return null for empty or null (optional field)', () {
      expect(FormValidator.validatePhoneNumber(null), null);
      expect(FormValidator.validatePhoneNumber(''), null);
    });

    test('should return error for too short or too long numbers', () {
      expect(
          FormValidator.validatePhoneNumber('12345678'), 'Teléfono inválido');
      expect(
          FormValidator.validatePhoneNumber('+12345678'), 'Teléfono inválido');
      expect(FormValidator.validatePhoneNumber('1234567890123456'),
          'Teléfono inválido');
      expect(FormValidator.validatePhoneNumber('+1234567890123456'),
          'Teléfono inválido');
    });

    test('should return error for invalid characters', () {
      expect(FormValidator.validatePhoneNumber('123-456-789'),
          'Teléfono inválido');
      expect(FormValidator.validatePhoneNumber('123 456 789'),
          'Teléfono inválido');
      expect(FormValidator.validatePhoneNumber('+34-600000000'),
          'Teléfono inválido');
      expect(FormValidator.validatePhoneNumber('abc123456789'),
          'Teléfono inválido');
    });
  });

  group('FormValidator - maskEmail', () {
    test('should mask normal email addresses', () {
      expect(FormValidator.maskEmail('user@example.com'), 'us***@example.com');
      expect(FormValidator.maskEmail('john.doe@domain.co'), 'jo***@domain.co');
    });

    test('should mask short user names', () {
      expect(FormValidator.maskEmail('a@example.com'), 'a***@example.com');
      expect(FormValidator.maskEmail('ab@example.com'), 'a***@example.com');
    });

    test('should return original if invalid format', () {
      expect(FormValidator.maskEmail('invalidemail'), 'invalidemail');
      expect(FormValidator.maskEmail(''), '');
    });
  });

  group('InternationalPhoneFormatter', () {
    final formatter = InternationalPhoneFormatter();

    test('should add + to digit-only input and include spaces', () {
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '346'),
      );
      expect(result.text, '+34 6');
    });

    test('should keep + if present and include spaces', () {
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '+346'),
      );
      expect(result.text, '+34 6');
    });

    test('should allow only digits and first +, and format with spaces', () {
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '+346-666'),
      );
      expect(result.text, '+34 666 6');
    });

    test('should limit to 15 digits after + and format with spaces', () {
      final result = formatter.formatEditUpdate(
        TextEditingValue.empty,
        const TextEditingValue(text: '1234567890123456789'),
      );
      expect(result.text, '+12 345 678 901 234 5');
    });
  });
}
