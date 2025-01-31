import 'package:flutter/cupertino.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeUpdateUser extends HomeEvent {}
