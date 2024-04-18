import 'package:equatable/equatable.dart';

class EmptySlotEntity extends Equatable{

  final room;
  final time;
  final day;

  EmptySlotEntity({
  required this.day,
    required this.room,
    required this.time
  });

  @override
  List<Object?> get props => throw UnimplementedError();

}