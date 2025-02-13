import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class NavState {
  const NavState();
}

sealed class NavBarState extends NavState {
  const NavBarState();
}

sealed class NavBarActionState extends NavBarState {}

class NavInitialState extends NavBarState {}

class NavLoadingState extends NavBarState {}

class NavSuccessState extends NavBarState {}

class NavFailedState extends NavBarState {
  final String errorMessage;

  const NavFailedState(this.errorMessage);
}

class SignOutFromNav extends NavBarActionState {}

class SignOutConfirm extends NavBarActionState {}

class SignOutFailed extends NavBarState {
  final String message;

  const SignOutFailed(this.message);
}

sealed class EditProfile extends NavState {
  const EditProfile();
}

sealed class EditProfileActionState extends EditProfile {}

class EditProfileState extends EditProfileActionState {}

class EditProfileLoadingState extends EditProfile {}

class EditProfileSucceed extends EditProfile {}

class EditProfileFailed extends EditProfile {
  final String message;

  const EditProfileFailed(this.message);
}

sealed class ChangePassword extends NavState {
  const ChangePassword();
}

sealed class ChangePasswordActionState extends ChangePassword {}

class ChangePasswordState extends ChangePasswordActionState {}

class ChangePasswordLoadingState extends ChangePassword {}

class ChangePassSucceed extends ChangePassword {}

class ChangePassFailed extends ChangePassword {
  final String message;

  const ChangePassFailed(this.message);
}
