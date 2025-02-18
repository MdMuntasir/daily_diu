import 'package:diu_student/features/authentication/presentation/bloc/auth_state.dart';

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

class AuthLoginConfirmEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginConfirmEvent({
    required this.email,
    required this.password,
  });
}

class AuthLoginForgotPasswordEvent extends AuthEvent {
  final String email;

  const AuthLoginForgotPasswordEvent(this.email);
}
