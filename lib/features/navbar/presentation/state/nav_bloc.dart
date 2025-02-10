import 'dart:async';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/navbar/Domain/usecase/nav_signout_usecase.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_event.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  final UserEntity user;
  final NavSignOutUseCase navSignOutUseCase;

  NavBloc({
    required this.user,
    required this.navSignOutUseCase,
  }) : super(NavInitialState()) {
    on<NavInitialEvent>(navInitialEvent);
    on<SignOutFromNavEvent>(signOutFromNavEvent);
    on<SignOutConfirmEvent>(signOutConfirmEvent);
  }

  FutureOr<void> navInitialEvent(
      NavInitialEvent event, Emitter<NavState> emit) {
    emit(NavSuccessState(user));
  }

  FutureOr<void> signOutFromNavEvent(
      SignOutFromNavEvent event, Emitter<NavState> emit) {
    emit(SignOutFromNav());
  }

  FutureOr<void> signOutConfirmEvent(
      SignOutConfirmEvent event, Emitter<NavState> emit) async {
    final state = await navSignOutUseCase();
    if (state is DataSuccess) {
      emit(SignOutConfirm());
    } else {
      emit(SignOutFailed());
    }
  }
}
