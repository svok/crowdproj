import 'package:equatable/equatable.dart';

abstract class TeamState extends Equatable {
  TeamState({this.isWaiting = false}): super();
  final bool isWaiting;
}
