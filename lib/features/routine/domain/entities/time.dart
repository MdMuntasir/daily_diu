import 'package:equatable/equatable.dart';

class TimeEntity extends Equatable{
  final List? times;


  const TimeEntity({
    this.times,
  });

  @override

  List<Object?> get props => [
    times,
  ];
}
