import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/core/util/api_exception.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/core/util/filter.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDatasource _datasource = locator.get();

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks(Filter? filter) async {
    try {
      var response = await _datasource.getAllTasks(filter);
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, TaskModel>> getTask(String id) async {
    try {
      var response = await _datasource.getTask(id);
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addTask(TaskModel taskModel) async {
    try {
      await _datasource.addTask(taskModel);
      return right(Constants.TASK_SAVED_MESSAGE);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateTask(TaskModel taskModel) async {
    try {
      await _datasource.updateTask(taskModel);
      return right(Constants.TASK_SAVED_MESSAGE);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateTaskStatus(
      String id, bool status) async {
    try {
      await _datasource.updateTaskStatus(id, status);
      return right(Constants.TASK_SAVED_MESSAGE);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteTask(String id) async {
    try {
      await _datasource.deleteTask(id);
      return right(Constants.TASK_DELETED_MESSAGE);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }
}
