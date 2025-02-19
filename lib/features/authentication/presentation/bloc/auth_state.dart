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

sealed class AuthSignUp extends AuthState {
  const AuthSignUp();
}

sealed class AuthVerification extends AuthState {
  const AuthVerification();
}

class AuthInitialState extends AuthState {}

// Login Page States
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

// SignUp Page States
class AuthSignUpState extends AuthActionState {
  final UserEntity user;
  final String confirmPassword;

  const AuthSignUpState({
    required this.user,
    required this.confirmPassword,
  });
}

class AuthSignUpLoading extends AuthSignUp {}

class AuthSignUpSucceed extends AuthSignUp {
  final UserEntity user;

  const AuthSignUpSucceed(this.user);
}

class AuthSignUpFailed extends AuthSignUp {
  final String message;

  const AuthSignUpFailed(this.message);
}

// Verification Page States
class AuthVerificationLoading extends AuthVerification {}

class AuthVerifiedState extends AuthVerification {
  final String message;

  const AuthVerifiedState(this.message);
}

class AuthVerificationFailed extends AuthVerification {
  final String message;

  const AuthVerificationFailed(this.message);
}
