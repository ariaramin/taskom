import 'package:dartz/dartz.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/core/util/filter.dart';
import 'package:taskom/features/task/data/models/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskModel>>> getAllTasks(Filter? filter);

  Future<Either<Failure, TaskModel>> getTask(String id);

  Future<Either<Failure, String>> addTask(TaskModel taskModel);

  Future<Either<Failure, String>> updateTask(TaskModel taskModel);

  Future<Either<Failure, String>> updateTaskStatus(String id, bool status);

  Future<Either<Failure, String>> deleteTask(String id);
}
