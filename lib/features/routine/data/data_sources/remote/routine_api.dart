import 'package:dio/dio.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:diu_student/features/routine/data/models/time.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
part 'routine_api.g.dart';


@RestApi(baseUrl : routine_api)
abstract class RoutineApi{
  factory RoutineApi(Dio dio) = _RoutineApi;

  @GET("/student-routine/{batch}")
  Future<HttpResponse<List<SlotModel>>> getStudentRoutineJson(@Path("batch") String batch);

  @GET("/teacher-routine/{ti}")
  Future<HttpResponse<List<SlotModel>>> getTeacherRoutineJson(@Path("ti") String ti);

  @GET("/times")
  Future<HttpResponse<List<TimeModel>>> getTimes();
}


