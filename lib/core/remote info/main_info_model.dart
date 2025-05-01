import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MainInfoEntity extends Equatable {
  final String api;
  final String resultApi;

  const MainInfoEntity({required this.api, required this.resultApi});

  @override
  List<Object?> get props => [api];
}

class MainInfoModel extends MainInfoEntity {
  const MainInfoModel({
    required super.api,
    required super.resultApi,
  });

  factory MainInfoModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final map = document.data()!;
    return MainInfoModel(
      api: map["API"] ?? "",
      resultApi: map["resultApi"] ?? "",
    );
  }
}
