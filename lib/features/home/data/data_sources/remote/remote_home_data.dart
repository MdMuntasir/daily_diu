import 'package:dio/dio.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/model/slot.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import '../../../../../core/links/api_links.dart';

final dio = Dio();

abstract class RemoteHomeData {
  Future<DataState<List<SlotModel>>> userRoutine({required UserEntity user});
}

class RemoteHomeDataImpl implements RemoteHomeData {
  @override
  Future<DataState<List<SlotModel>>> userRoutine(
      {required UserEntity user}) async {
    List<SlotModel> routine = [];

    try {
      final response = user.user == "Student"
          ? await dio.get(
              "$routine_api/${user.department}/student-routine?batchSection=${user.batch}${user.section}")
          : await dio.get(
              "$routine_api/${user.department}/full-teacher-routine?teacherInitial=${user.ti}");

      if (response.statusCode == 200) {
        final responseData = response.data;
        for (Map<String, dynamic> slot in responseData) {
          routine.add(SlotModel.fromJson(slot));
        }
        return DataSuccess(routine);
      } else {
        return DataFailed(response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
