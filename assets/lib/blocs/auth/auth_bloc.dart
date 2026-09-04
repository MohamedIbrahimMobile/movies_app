import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/auth/auth_event.dart';
import 'package:movies_app/blocs/auth/auth_state.dart';
import 'package:movies_app/data/repositories/auth_repository.dart';
import 'package:movies_app/utils/auth_error_handler.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<GoogleLoginEvent>(_onGoogleLogin);
    on<ForgetPasswordEvent>(_onForgetPassword);
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onRegister(RegisterEvent event,
      Emitter<AuthState> emit,) async {
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
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }

  Future<void> _onLogin(LoginEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(LoginSuccess());
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }

  Future<void> _onGoogleLogin(GoogleLoginEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      await authRepository.loginWithGoogle();

      emit(GoogleLoginSuccess());
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }

  Future<void> _onForgetPassword(ForgetPasswordEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      await authRepository.sendPasswordResetEmail(
        email: event.email,
      );

      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }

  Future<void> _onLoadProfile(LoadProfileEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      final user = await authRepository.getCurrentUserProfile();

      if (user == null) {
        emit(const AuthError('user_data_not_found'));
        return;
      }

      emit(ProfileLoaded(user));
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      await authRepository.updateProfile(
        name: event.name,
        phone: event.phone,
        avatarIndex: event.avatarIndex,
      );

      emit(UpdateProfileSuccess());
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }

  Future<void> _onDeleteAccount(DeleteAccountEvent event,
      Emitter<AuthState> emit,) async {
    emit(AuthLoading());

    try {
      await authRepository.deleteAccount();

      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(AuthError(AuthErrorHandler.handle(e)));
    }
  }
}