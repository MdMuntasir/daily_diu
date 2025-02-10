import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class NavState {
  const NavState();
}

sealed class NavActionState extends NavState {}

class NavInitialState extends NavState {}

class NavLoadingState extends NavState {}

class NavSuccessState extends NavState {
  final UserEntity user;

  const NavSuccessState(this.user);
}

class NavFailedState extends NavState {
  final String errorMessage;

  const NavFailedState(this.errorMessage);
}

class SignOutFromNav extends NavActionState {}

class SignOutConfirm extends NavActionState {}

class SignOutFailed extends NavActionState {}
