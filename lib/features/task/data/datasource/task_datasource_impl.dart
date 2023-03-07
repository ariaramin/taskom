import 'package:dio/dio.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/util/api_exception.dart';
import 'package:taskom/features/task/data/util/filter.dart';

class TaskDatasourceImpl extends TaskDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<TaskModel>> getAllTasks(Filter? filter) async {
    try {
      var response = await _dio.get(
        Constants.TASKS_RECORDS_URL,
        queryParameters: {
          "filter": filter?.filterSequence,
        },
      );
      return response.data['items']
          .map<TaskModel>((jsonObject) => TaskModel.fromMapJson(jsonObject))
          .toList();
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<TaskModel> getTask(String id) async {
    try {
      var response = await _dio.get(
        Constants.TASKS_RECORDS_URL,
        queryParameters: {
          "filter": "id='$id'",
        },
      );
      return response.data['items']
          .map<TaskModel>((jsonObject) => TaskModel.fromMapJson(jsonObject))
          .toList()[0];
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future addTask(TaskModel taskModel) async {
    try {
      await _dio.post(
        Constants.TASKS_RECORDS_URL,
        data: taskModel.toJson(),
      );
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future updateTask(TaskModel taskModel) async {
    try {
      await _dio.patch(
        "${Constants.TASKS_RECORDS_URL}:${taskModel.id}",
        data: taskModel.toJson(),
      );
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deleteTask(String id) async {
    try {
      await _dio.delete("${Constants.TASKS_RECORDS_URL}:${id}");
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }
}