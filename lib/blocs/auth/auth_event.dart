import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final int avatarIndex;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.avatarIndex,
  });

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    phone,
    avatarIndex,
  ];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}

class GoogleLoginEvent extends AuthEvent {
  const GoogleLoginEvent();
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  const ForgetPasswordEvent({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class LoadProfileEvent extends AuthEvent {
  const LoadProfileEvent();
}

class UpdateProfileEvent extends AuthEvent {
  final String name;
  final String phone;
  final int avatarIndex;

  const UpdateProfileEvent({
    required this.name,
    required this.phone,
    required this.avatarIndex,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    avatarIndex,
  ];
}

class DeleteAccountEvent extends AuthEvent {
  const DeleteAccountEvent();
}