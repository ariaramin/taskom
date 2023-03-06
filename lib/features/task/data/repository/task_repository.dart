import 'package:dartz/dartz.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/util/failure.dart';

abstract class TaskRepository {
  Either<Failure, List<TaskModel>> getAllTasks();

  Either<Failure, TaskModel> getTask(String id);

  Future<Either<Failure, String>> addUpdateTask(String id, TaskModel item);

  Future<Either<Failure, String>> deleteTask(String id);
}
