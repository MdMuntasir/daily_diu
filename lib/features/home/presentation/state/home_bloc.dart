import 'dart:async';

import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_state.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/home/domain/usecases/home_usecase.dart';
import 'package:diu_student/features/home/presentation/state/home_event.dart';
import 'package:diu_student/features/home/presentation/state/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;
  final AppUserCubit _appUserCubit;

  HomeBloc({
    required HomeUseCase homeUseCase,
    required AppUserCubit appUserCubit,
  })  : _homeUseCase = homeUseCase,
        _appUserCubit = appUserCubit,
        super(LoadingHomeState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeUpdateUser>(homeUpdateUser);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());
    final userState = _appUserCubit.state;
    final dataState = await _homeUseCase();
    if (dataState is DataSuccess && userState is LoggedAppUser) {
      final user = userState.user;
      final routine = dataState.data!;
      emit(HomeSuccessState(user, routine));
    } else {
      emit(HomeFailedState(dataState.error.toString()));
    }
  }

  FutureOr<void> homeUpdateUser(
      HomeUpdateUser event, Emitter<HomeState> emit) async {
    await _appUserCubit.updateUser();
  }
}
