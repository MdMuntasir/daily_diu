import 'package:flutter/cupertino.dart';

@immutable
sealed class ResultEvent {}

class ResultInitialEvent extends ResultEvent {}

class ResultCGPAShowActionEvent extends ResultEvent {}

class ResultNavigateToNavBarEvent extends ResultEvent {}
