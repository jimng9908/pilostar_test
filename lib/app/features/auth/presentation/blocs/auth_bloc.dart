import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/injection.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUserUsecase loginUser;
  final LoginWithGoogleUseCase loginWithGoogle;
  final RegisterUserUseCases registerUser;
  final VerifyCode verifyCode;
  final RegisterWithGoogleUseCase registerWithGoogle;
  final GetLocalUserUsecase getLocalUser;
  final SaveLocalUserUsecase saveLocalUser;
  final CleanDataUsecase cleanData;
  final VerifyBusinessConfig verifyBusinessConfig;

  AuthBloc({
    required this.loginUser,
    required this.loginWithGoogle,
    required this.registerUser,
    required this.verifyCode,
    required this.registerWithGoogle,
    required this.getLocalUser,
    required this.saveLocalUser,
    required this.cleanData,
    required this.verifyBusinessConfig,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<GoogleRegisterRequested>(_onGoogleRegisterRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<VerifyCodeRequested>(_onVerifyCodeRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final userResult = await getLocalUser();

      await userResult.fold((failure) async {
        await cleanData.call();
        emit(AuthUnauthenticated());
      }, (user) async {
        final validationResult = _validateAccessToken(user?.tokenExpiry);

        if (validationResult) {
          if (user != null) {
            await _onVerifyBusinessConfig(user, emit);
          }
        } else {
          await cleanData.call();
          emit(AuthUnauthenticated());
        }
      });
    } catch (e) {
      await cleanData.call();
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await loginUser(
        LoginRequest(
          email: event.email,
          password: event.password,
        ),
      );

      await result.fold(
        (failure) async {
          emit(AuthFailure(failure.errorMessage));
        },
        (user) async {
          try {
            await _onVerifyBusinessConfig(user, emit);
          } catch (e) {
            final errorMessage =
                FailureMapper.mapFailureToMessage(e as Failure);
            emit(AuthFailure(errorMessage));
          }
        },
      );
    } catch (e) {
      final errorMessage = FailureMapper.mapFailureToMessage(e as Failure);
      emit(AuthFailure(errorMessage));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final result = await registerUser(
        RegisterRequest(
            name: event.name,
            lastName: event.lastName,
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber,
            isActive: true),
      );

      await result.fold(
        (failure) async {
          final errorMessage = FailureMapper.mapFailureToMessage(failure);
          emit(AuthFailure(errorMessage));
        },
        (response) async {
          try {
            emit(UserRegistered(
                registerResponse: response, password: event.password));
          } catch (e) {
            final errorMessage =
                FailureMapper.mapFailureToMessage(e as Failure);
            emit(AuthFailure(errorMessage));
          }
        },
      );
    } catch (e) {
      final errorMessage = FailureMapper.mapFailureToMessage(e as Failure);
      emit(AuthFailure(errorMessage));
    }
  }

  Future<void> _onVerifyCodeRequested(
    VerifyCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is! UserRegistered) {
      emit(AuthFailure('No se ha registrado el usuario'));
      return;
    }
    try {
      emit(currentState.copyWith(verifyInProgress: true));
      final result = await verifyCode(
        event.email,
        event.code,
        currentState.password,
      );

      await result.fold(
        (failure) async {
          final errorMessage = FailureMapper.mapFailureToMessage(failure);
          emit(AuthFailure(errorMessage));
        },
        (user) async {
          try {
            await saveLocalUser(user);
            emit(currentState.copyWith(user: user, verifyInProgress: false));
          } catch (e) {
            final errorMessage =
                FailureMapper.mapFailureToMessage(e as Failure);
            emit(AuthFailure(errorMessage));
          }
        },
      );
    } catch (e) {
      final errorMessage = FailureMapper.mapFailureToMessage(e as Failure);
      emit(AuthFailure(errorMessage));
    } finally {
      emit(currentState.copyWith(verifyInProgress: false));
    }
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await loginWithGoogle();

      await result.fold(
        (failure) async {
          emit(AuthFailure(failure.errorMessage));
        },
        (user) async {
          try {
            await _onVerifyBusinessConfig(user, emit);
          } catch (e) {
            final errorMessage =
                FailureMapper.mapFailureToMessage(e as Failure);
            emit(AuthFailure(errorMessage));
          }
        },
      );
    } catch (e) {
      final errorMessage = FailureMapper.mapFailureToMessage(e as Failure);
      emit(AuthFailure(errorMessage));
    }
  }

  Future<void> _onGoogleRegisterRequested(
    GoogleRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await registerWithGoogle();

      await result.fold(
        (failure) async {
          emit(AuthFailure(failure.errorMessage));
        },
        (user) async {
          try {
            await saveLocalUser(user);
            emit(UserRegistered(user: user, password: ''));
          } catch (e) {
            final errorMessage =
                FailureMapper.mapFailureToMessage(e as Failure);
            emit(AuthFailure(errorMessage));
          }
        },
      );
    } catch (e) {
      final errorMessage = FailureMapper.mapFailureToMessage(e as Failure);
      emit(AuthFailure(errorMessage));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    resetUserBlocs();
    await cleanData.call();
    await Future.delayed(const Duration(milliseconds: 500));
    emit(AuthUnauthenticated());
  }

  bool _validateAccessToken(DateTime? tokenExpiry) {
    return tokenExpiry != null && DateTime.now().isBefore(tokenExpiry);
  }

  Future<void> _onVerifyBusinessConfig(
    UserEntity user,
    Emitter<AuthState> emit,
  ) async {
    try {
      final result = await verifyBusinessConfig(user.accessToken, user.userId);

      await result.fold(
        (failure) async {
          emit(AuthFailure(failure.errorMessage));
        },
        (isConfigured) async {
          if (isConfigured) {
            await saveLocalUser(user);
            emit(AuthAuthenticated(user: user));
          } else {
            await saveLocalUser(user);
            emit(BusinessConfigRequired());
          }
        },
      );
    } catch (e) {
      final errorMessage = FailureMapper.mapFailureToMessage(e as Failure);
      emit(AuthFailure(errorMessage));
    }
  }
}
