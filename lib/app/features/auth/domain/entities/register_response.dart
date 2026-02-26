import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/payment_plans/payment.dart';

class RegisterResponse extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? picture;
  final bool? isActive;
  final String? verificationCode;
  final DateTime? verificationCodeExpires;
  final List<PaymentSubscriptionStatusEntity>? subscriptions;

  const RegisterResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.picture,
    this.isActive,
    this.verificationCode,
    this.verificationCodeExpires,
    this.subscriptions,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        picture,
        isActive,
        verificationCode,
        verificationCodeExpires,
        subscriptions,
      ];
}
