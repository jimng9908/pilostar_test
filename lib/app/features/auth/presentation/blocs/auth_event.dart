part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  // final String? address;
  // final String? locality;
  // final String? country;

  const RegisterRequested({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    // this.address,
    // this.locality,
    // this.country,
  });

  @override
  List<Object> get props => [name, lastName, email, password];
}

class VerifyCodeRequested extends AuthEvent {
  final String email;
  final String code;

  const VerifyCodeRequested({
    required this.email,
    required this.code,
  });

  @override
  List<Object> get props => [email, code];
}

class LogoutRequested extends AuthEvent {}

class TokenExpired extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class GoogleLoginRequested extends AuthEvent {}

class GoogleRegisterRequested extends AuthEvent {}
