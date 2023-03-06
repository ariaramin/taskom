import 'package:dartz/dartz.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';
import 'package:taskom/features/task/data/util/db_exception.dart';
import 'package:taskom/features/task/data/util/failure.dart';

class TaskRepositoryImpl extends TaskRepository {
  TaskDatasource _datasource = locator.get();

  @override
  Either<Failure, List<TaskModel>> getAllTasks() {
    try {
      var allTasks = _datasource.getAllTasks();
      return right(allTasks);
    } on DbException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Either<Failure, TaskModel> getTask(String id) {
    try {
      var task = _datasource.getTask(id);
      return right(task);
    } on DbException catch (error) {
      return left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, String>> addUpdateTask(
    String id,
    TaskModel item,
  ) async {
    try {
      await _datasource.addUpdateTask(id, item);
      return right(Constants.TASK_DELETED_MESSAGE);
    } catch (_) {
      return left(Failure(Constants.ERROR_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, String>> deleteTask(String id) async {
    try {
      await _datasource.deleteTask(id);
      return right(Constants.TASK_DELETED_MESSAGE);
    } catch (_) {
      return left(Failure(Constants.ERROR_MESSAGE));
    }
  }
}
