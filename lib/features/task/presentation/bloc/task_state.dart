import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/util/failure.dart';

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

  TaskListResponse({required this.taskList});

  @override
  List<Object?> get props => [];
}
