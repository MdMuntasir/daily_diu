import 'package:flutter/cupertino.dart';

@immutable
sealed class NavEvent {}

class NavInitialEvent extends NavEvent {}

class NavLoadingEvent extends NavEvent {}

class NavSuccessEvent extends NavEvent {}

class NavFailedEvent extends NavEvent {}

class SignOutFromNavEvent extends NavEvent {}

class SignOutConfirmEvent extends NavEvent {}
