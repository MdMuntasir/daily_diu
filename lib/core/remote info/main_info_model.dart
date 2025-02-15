import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MainInfoEntity extends Equatable {
  final String api;

  const MainInfoEntity({
    required this.api,
  });

  @override
  List<Object?> get props => [api];
}

class MainInfoModel extends MainInfoEntity {
  const MainInfoModel({required super.api});

  factory MainInfoModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final map = document.data()!;
    return MainInfoModel(api: map["API"] ?? "");
  }
}
