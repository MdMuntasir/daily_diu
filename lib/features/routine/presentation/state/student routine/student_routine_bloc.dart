import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_event.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/student/routine_usecase.dart';
import '../../../domain/usecases/time_usecase.dart';

class StudentRoutineBloc extends Bloc<StudentRoutineEvents, StudentRoutineState>{

  final GetStudentRoutineUseCase _getStudentRoutineUseCase;


  StudentRoutineBloc(this._getStudentRoutineUseCase, ) : super( StudentRoutineLoading()){
    on<getStudentRoutine> (onGetStudentRoutine);
  }

  Future<void> onGetStudentRoutine(getStudentRoutine event, Emitter<StudentRoutineState> emit) async {
    final dataState = await _getStudentRoutineUseCase();


    if(dataState is DataSuccess && dataState.data!.isNotEmpty )
      {
        emit(
          StudentRoutineDone(dataState.data!)
        );
      }
    else if(dataState is DataFailed){
      emit(
        StudentRoutineError(dataState.error!)
      );
    }
  }
}