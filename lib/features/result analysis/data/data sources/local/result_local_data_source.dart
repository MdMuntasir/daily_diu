import 'package:diu_student/features/result%20analysis/data/model/semesterResultModel.dart';
import 'package:hive/hive.dart';

abstract class ResultLocalDataSource {
  void uploadData({required List<List<SemesterResultModel>> results});

  List<List<SemesterResultModel>> fetchData();
}

class ResultLocalDataSourceImpl implements ResultLocalDataSource {
  final Box box;

  ResultLocalDataSourceImpl(this.box);

  @override
  List<List<SemesterResultModel>> fetchData() {
    List<List<SemesterResultModel>> results = [];
    for (int i = 0; i < box.length; i++) {
      List<SemesterResultModel> temp = [];
      List data = box.get(i.toString());
      for (Map<String, dynamic> result in data) {
        temp.add(SemesterResultModel.fromJson(result));
      }
      results.add(temp);
    }

    return results;
  }

  @override
  void uploadData({required List<List<SemesterResultModel>> results}) {
    box.clear();
    for (int i = 0; i < results.length; i++) {
      List<Map<String, dynamic>> temp = [];
      for (int j = 0; j < results[i].length; j++) {
        temp.add(results[i][j].toJson());
      }
      box.put(i.toString(), temp);
    }
  }
}
