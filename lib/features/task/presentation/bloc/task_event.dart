import 'package:equatable/equatable.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';

abstract class TaskEvent extends Equatable {}

class TaskListRequestEvent extends TaskEvent {
  final TaskListParams? taskListParams;

  TaskListRequestEvent({this.taskListParams});

  @override
  List<Object?> get props => [];
}

class TaskDateListRequestEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class TaskImageListRequestEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}
