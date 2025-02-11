import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class NavEvent {
  const NavEvent();
}

sealed class NavEditProfileEvent extends NavEvent {
  const NavEditProfileEvent();
}

class NavInitialEvent extends NavEvent {}

class NavLoadingEvent extends NavEvent {}

class NavSuccessEvent extends NavEvent {}

class NavFailedEvent extends NavEvent {}

class SignOutFromNavEvent extends NavEvent {}

class SignOutConfirmEvent extends NavEvent {}

class EditProfileEvent extends NavEditProfileEvent {}

class EditProfileConfirmEvent extends NavEditProfileEvent {
  final UserEntity user;

  const EditProfileConfirmEvent(this.user);
}
