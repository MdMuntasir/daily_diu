import 'package:diu_student/features/result%20analysis/domain/entities/semesterResultEntity.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class ResultState {
  const ResultState();
}

sealed class ResultActionState extends ResultState {}

class ResultInitialState extends ResultState {}

class ResultLoadingState extends ResultState {}

class ResultSuccessState extends ResultState {
  final List<List<SemesterResultEntity>> results;
  final double cgpa;

  const ResultSuccessState({required this.results, required this.cgpa});
}

class ResultEmptyState extends ResultState {}

class ResultFailureState extends ResultState {
  final String errorMessage;

  const ResultFailureState(this.errorMessage);
}

class ResultCGPAShowActionState extends ResultActionState {}

class ResultNavigateToNavBarActionState extends ResultActionState {}

class SearchResultSuccessState extends ResultState {
  final List<SemesterResultEntity> result;

  const SearchResultSuccessState(this.result);
}

class SearchResultLoadingState extends ResultState {}

class SearchResultFailedState extends ResultState {
  final String error;

  const SearchResultFailedState(this.error);
}
