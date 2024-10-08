import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MainKamlaEntity extends Equatable{
  final String api;

  const MainKamlaEntity({
    required this.api,
  });

  @override
  List<Object?> get props => [
    api
  ];
}


class MainKamlaModel extends MainKamlaEntity{
  const MainKamlaModel({required super.api});


  factory MainKamlaModel.fromSnapShot (DocumentSnapshot<Map<String, dynamic>> document){
    final map = document.data()!;
    return MainKamlaModel(api: map["API"] ?? "");
  }
}