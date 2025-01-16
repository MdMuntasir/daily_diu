import 'dart:async';

import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/result%20analysis/data/data%20sources/local/result_local_data_source.dart';
import 'package:diu_student/features/result%20analysis/data/data%20sources/remote/api_data_source.dart';
import 'package:diu_student/features/result%20analysis/data/repository/resultRepositoryImp.dart';
import 'package:diu_student/features/result%20analysis/domain/usecase/result_usecase.dart';
import 'package:diu_student/features/result%20analysis/presentation/state/result_event.dart';
import 'package:diu_student/features/result%20analysis/presentation/state/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  late final double cgpa;
  final String id;

  ResultBloc({required this.id}) : super(ResultLoadingState()) {
    on<ResultInitialEvent>(resultInitialEvent);

    on<ResultCGPAShowActionEvent>(resultCGPAShowActionEvent);

    on<ResultNavigateToNavBarEvent>(resultNavigateToNavBarEvent);
  }

  FutureOr<void> resultInitialEvent(
      ResultInitialEvent event, Emitter<ResultState> emit) async {
    emit(ResultLoadingState());
    final dataState = await ResultUseCase(ResultRepositoryImpl(
            RemoteResultImpl(id),
            RemoteSemestersImpl(),
            ConnectionCheckerImpl(
              InternetConnection(),
            ),
            ResultLocalDataSourceImpl(Hive.box("Results"))))
        .call();
    if (dataState is DataSuccess) {
      if (dataState.data!.isNotEmpty) {
        double cgpa = 0;
        for (var semester in dataState.data!) {
          cgpa += semester[0].cgpa;
        }
        cgpa = double.parse((cgpa / dataState.data!.length).toStringAsFixed(2));
        emit(ResultSuccessState(
          results: dataState.data!,
          cgpa: cgpa,
        ));
      } else {
        emit(ResultEmptyState());
      }
    } else if (dataState is DataFailed) {
      emit(ResultFailureState(dataState.error.toString()));
    }
  }

  FutureOr<void> resultNavigateToNavBarEvent(
      ResultNavigateToNavBarEvent event, Emitter<ResultState> emit) {
    emit(ResultNavigateToNavBarActionState());
  }

  FutureOr<void> resultCGPAShowActionEvent(
      ResultCGPAShowActionEvent event, Emitter<ResultState> emit) {
    emit(ResultCGPAShowActionState());
  }
}
