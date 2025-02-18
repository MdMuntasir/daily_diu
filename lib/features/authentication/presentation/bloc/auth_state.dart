import 'package:diu_student/core/util/Entities/user_info.dart';

sealed class AuthState {
  const AuthState();
}

sealed class AuthActionState extends AuthState {
  const AuthActionState();
}

sealed class AuthLogin extends AuthState {
  const AuthLogin();
}

sealed class AuthSignUp extends AuthState {}

sealed class AuthVerification extends AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoginState extends AuthActionState {
  final String email;
  final String password;

  const AuthLoginState({
    required this.email,
    required this.password,
  });
}

class AuthLoginLoading extends AuthLogin {}

class AuthLoginSucceed extends AuthLogin {
  final UserEntity user;

  const AuthLoginSucceed(this.user);
}

class AuthLoginFailed extends AuthLogin {
  final String message;

  const AuthLoginFailed(this.message);
}

class AuthLoginNotVerified extends AuthLogin {
  final UserEntity user;

  const AuthLoginNotVerified(this.user);
}

class AuthLoginForgotPassword extends AuthActionState {
  final String message;

  const AuthLoginForgotPassword(this.message);
}
