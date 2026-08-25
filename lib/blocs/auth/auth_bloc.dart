import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/auth/auth_event.dart';
import 'package:movies_app/blocs/auth/auth_state.dart';
import 'package:movies_app/data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<GoogleLoginEvent>(_onGoogleLogin);
    on<ForgetPasswordEvent>(_onForgetPassword);
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onRegister(
      RegisterEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        avatarIndex: event.avatarIndex,
      );

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        AuthError(
          e.message ?? 'Registration failed.',
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogin(
      LoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        AuthError(
          e.message ?? 'Login failed.',
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGoogleLogin(
      GoogleLoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await authRepository.loginWithGoogle();

      emit(GoogleLoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        AuthError(
          e.message ?? 'Google login failed.',
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onForgetPassword(
      ForgetPasswordEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await authRepository.sendPasswordResetEmail(
        email: event.email,
      );

      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        AuthError(
          e.message ?? 'Something went wrong.',
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final user =
      await authRepository.getCurrentUserProfile();

      if (user == null) {
        emit(
          const AuthError(
            'User data not found.',
          ),
        );
        return;
      }

      emit(ProfileLoaded(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await authRepository.updateProfile(
        name: event.name,
        phone: event.phone,
        avatarIndex: event.avatarIndex,
      );

      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      await authRepository.deleteAccount();

      emit(DeleteAccountSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        AuthError(
          e.message ?? 'Something went wrong.',
        ),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}