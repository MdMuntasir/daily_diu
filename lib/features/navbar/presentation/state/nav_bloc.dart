import 'dart:async';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/navbar/Domain/usecase/nav_editprofile_usecase.dart';
import 'package:diu_student/features/navbar/Domain/usecase/nav_signout_usecase.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_event.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  final UserEntity user;
  final NavSignOutUseCase navSignOutUseCase;
  final EditProfileUseCase editProfileUseCase;

  NavBloc({
    required this.user,
    required this.navSignOutUseCase,
    required this.editProfileUseCase,
  }) : super(NavInitialState()) {
    on<NavInitialEvent>(navInitialEvent);

    on<SignOutFromNavEvent>(signOutFromNavEvent);
    on<SignOutConfirmEvent>(signOutConfirmEvent);

    on<EditProfileEvent>(editProfileEvent);
    on<EditProfileConfirmEvent>(editProfileConfirmEvent);

    on<EditPassEvent>(editPassEvent);
    on<EditPassConfirmEvent>(editPassConfirmEvent);
  }

  FutureOr<void> navInitialEvent(
      NavInitialEvent event, Emitter<NavState> emit) {
    emit(NavInitialState());
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
      emit(SignOutFailed(state.error.toString()));
    }
  }

  FutureOr<void> editProfileEvent(
      EditProfileEvent event, Emitter<NavState> emit) {
    emit(EditProfileState());
  }

  FutureOr<void> editProfileConfirmEvent(
      EditProfileConfirmEvent event, Emitter<NavState> emit) async {
    emit(EditProfileLoadingState());
    final state = await editProfileUseCase(para: event.user);
    if (state is DataSuccess) {
      emit(EditProfileSucceed());
    } else {
      emit(EditProfileFailed(state.error.toString()));
    }
  }

  FutureOr<void> editPassEvent(EditPassEvent event, Emitter<NavState> emit) {
    emit(EditProfileState());
  }

  FutureOr<void> editPassConfirmEvent(
      EditPassConfirmEvent event, Emitter<NavState> emit) async {
    emit(EditProfileLoadingState());
    final state = await editProfileUseCase(para: event.user);
    if (state is DataSuccess) {
      emit(EditProfileSucceed());
    } else {
      emit(EditProfileFailed(state.error.toString()));
    }
  }
}
