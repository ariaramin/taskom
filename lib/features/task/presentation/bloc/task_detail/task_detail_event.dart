import 'package:equatable/equatable.dart';

abstract class TaskDetailEvent extends Equatable {}

class TaskImageListRequestEvent extends TaskDetailEvent {
  @override
  List<Object?> get props => [];
}
