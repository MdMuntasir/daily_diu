import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

// Future<void> initializeDependency() async {
//   sl.registerSingleton<Dio>(Dio());
//
//   // sl.registerSingleton<RoutineApi>(RoutineApi(sl()));
//
//   // sl.registerSingleton<SlotRepository>(StudentRoutineImpl(sl()));
//   sl.registerSingleton<GetStudentRoutineUseCase>(
//       GetStudentRoutineUseCase(sl()));
//
//   // sl.registerSingleton<EmptySlotRepository>(EmptySlotRepoImpl(sl()));
//   sl.registerSingleton<GetEmptySlotUseCase>(GetEmptySlotUseCase(sl()));
// }
//
// Future<void> initializeStudentDependency() async {
//   // sl.registerFactory<StudentRoutineImpl>(() => StudentRoutineImpl(sl()));
//   sl.registerFactory<GetStudentRoutineUseCase>(
//       () => GetStudentRoutineUseCase(sl()));
// }
