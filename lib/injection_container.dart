import 'package:dio/dio.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/data/repository/empty%20slots/empty_slot_repo_impl.dart';
import 'package:diu_student/features/routine/data/repository/student/slot_repo_implement.dart';
import 'package:diu_student/features/routine/domain/repository/empty_slot_repository.dart';
import 'package:diu_student/features/routine/domain/repository/slot_repository.dart';
import 'package:diu_student/features/routine/domain/usecases/empty%20slot/empty_slot_usercase.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/routine/domain/usecases/student/routine_usecase.dart';
import 'features/routine/presentation/state/empty slots/empty_slots_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependency() async {

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<RoutineApi>(RoutineApi(sl()));
  
  sl.registerFactory<StudentRoutineBloc>(() => StudentRoutineBloc(sl()));
  sl.registerSingleton<SlotRepository>(StudentRoutineImpl(sl()));
  sl.registerSingleton<GetStudentRoutineUseCase>(GetStudentRoutineUseCase(sl()));

  sl.registerFactory<EmptySlotBloc>(() => EmptySlotBloc(sl()));
  sl.registerSingleton<EmptySlotRepository>(EmptySlotRepoImpl(sl()));
  sl.registerSingleton<GetEmptySlotUseCase>(GetEmptySlotUseCase(sl()));

}

Future<void> initializeStudentDependency() async {
  sl.registerFactory<StudentRoutineImpl>(() => StudentRoutineImpl(sl()));
  sl.registerFactory<GetStudentRoutineUseCase>(() => GetStudentRoutineUseCase(sl()));

}