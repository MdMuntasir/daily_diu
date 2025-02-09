import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

sealed class HomeActionState extends HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class HomeSuccessState extends HomeState {
  final UserEntity user;
  final List<SlotEntity> routine;

  const HomeSuccessState(this.user, this.routine);
}

class HomeFailedState extends HomeState {
  final String errorMessage;

  const HomeFailedState(this.errorMessage);
}
