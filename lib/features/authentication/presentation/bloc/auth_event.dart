import 'package:diu_student/core/util/Entities/user_info.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthInitialEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthLoginForgotPasswordEvent extends AuthEvent {
  final String email;

  const AuthLoginForgotPasswordEvent(this.email);
}

class AuthSignUpEvent extends AuthEvent {
  final UserEntity user;
  final String confirmPassword;

  const AuthSignUpEvent({
    required this.user,
    required this.confirmPassword,
  });
}

class AuthVerifyEvent extends AuthEvent {
  final UserEntity user;

  const AuthVerifyEvent({
    required this.user,
  });
}
