part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity? user;

  const AuthAuthenticated({this.user});

  @override
  List<Object?> get props => [user];
}

class UserRegistered extends AuthAuthenticated {
  final RegisterResponse? registerResponse;
  final String password;
  final bool verifyInProgress;

  const UserRegistered({
    super.user,
    this.registerResponse,
    required this.password,
    this.verifyInProgress = false,
  });

  UserRegistered copyWith({
    UserEntity? user,
    RegisterResponse? registerResponse,
    String? password,
    bool? verifyInProgress,
  }) {
    return UserRegistered(
      user: user ?? this.user,
      registerResponse: registerResponse ?? this.registerResponse,
      password: password ?? this.password,
      verifyInProgress: verifyInProgress ?? this.verifyInProgress,
    );
  }
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class BusinessConfigVerified extends AuthState {}

class BusinessConfigRequired extends AuthState {}

bool isLoading(AuthState state) {
  return state is AuthLoading;
}

bool isAuthenticated(AuthState state) {
  return state is AuthAuthenticated;
}

bool isUnauthenticated(AuthState state) {
  return state is AuthUnauthenticated;
}
