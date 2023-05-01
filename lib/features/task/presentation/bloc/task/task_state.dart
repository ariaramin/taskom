import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/config/util/failure.dart';

abstract class TaskState extends Equatable {}

class TaskInitState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {
  @override
  List<Object?> get props => [];
}

class TaskListResponse extends TaskState {
  final Either<Failure, List<TaskModel>> taskList;
  final List<DateTime>? dateList;

  TaskListResponse({
    required this.taskList,
    this.dateList,
  });

  @override
  List<Object?> get props => [taskList];
}

class TaskResponse extends TaskState {
  final Either<Failure, String> response;

  TaskResponse({required this.response});

  @override
  List<Object?> get props => [];
}
