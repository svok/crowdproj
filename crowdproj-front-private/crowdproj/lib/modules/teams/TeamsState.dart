import 'package:equatable/equatable.dart';


class TeamsState extends Equatable {
  TeamsState({this.isWaiting = false}): super();
  final bool isWaiting;

  @override
  List<Object> get props => [isWaiting];
}
