import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

class InitialAppUser extends AppUserState {}

class UnverifiedUser extends AppUserState {}

class LoggedAppUser extends AppUserState {
  final UserEntity user;

  const LoggedAppUser(this.user);
}

class UserFetchFailure extends AppUserState {
  final String errorMessage;

  const UserFetchFailure(this.errorMessage);
}
