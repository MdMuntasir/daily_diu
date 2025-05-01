import 'package:flutter/cupertino.dart';

@immutable
sealed class ResultEvent {
  const ResultEvent();
}

class ResultInitialEvent extends ResultEvent {}

class ResultCGPAShowActionEvent extends ResultEvent {}

class ResultNavigateToNavBarEvent extends ResultEvent {}

class SearchResultEvent extends ResultEvent {
  final String studentId;

  const SearchResultEvent(this.studentId);
}
