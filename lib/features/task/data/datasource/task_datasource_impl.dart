import 'package:dio/dio.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/core/util/api_exception.dart';
import 'package:taskom/core/util/filter.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/models/task.dart';

class TaskDatasourceImpl extends TaskDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<TaskModel>> getAllTasks(Filter? filter) async {
    try {
      if (AuthManager.isLogedIn()) {
        var response = await _dio.get(
          Constants.TASKS_RECORDS_URL,
          options: Options(
            headers: {"Authorization": "Bearer ${AuthManager.getToken()}"},
          ),
          queryParameters: {
            "filter": filter?.filterSequence,
          },
        );
        return response.data['items']
            .map<TaskModel>((jsonObject) => TaskModel.fromMapJson(jsonObject))
            .toList();
      }
      return [];
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
      if (AuthManager.isLogedIn()) {
        var response = await _dio.get(
          Constants.TASKS_RECORDS_URL,
          options: Options(
            headers: {"Authorization": "Bearer ${AuthManager.getToken()}"},
          ),
          queryParameters: {
            "filter": "id='$id'",
          },
        );
        return response.data['items']
            .map<TaskModel>((jsonObject) => TaskModel.fromMapJson(jsonObject))
            .toList()[0];
      }
      return TaskModel();
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
      if (AuthManager.isLogedIn()) {
        await _dio.post(
          Constants.TASKS_RECORDS_URL,
          options: Options(
            headers: {"Authorization": "Bearer ${AuthManager.getToken()}"},
          ),
          data: taskModel.toJson(),
        );
      }
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
      if (AuthManager.isLogedIn()) {
        await _dio.patch(
          "${Constants.TASKS_RECORDS_URL}/${taskModel.id}",
          options: Options(
            headers: {"Authorization": "Bearer ${AuthManager.getToken()}"},
          ),
          data: taskModel.toJson(),
        );
      }
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
  Future updateTaskStatus(String id, bool status) async {
    try {
      if (AuthManager.isLogedIn()) {
        await _dio.patch(
          "${Constants.TASKS_RECORDS_URL}/$id",
          options: Options(
            headers: {"Authorization": "Bearer ${AuthManager.getToken()}"},
          ),
          data: {"isDone": status},
        );
      }
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
      if (AuthManager.isLogedIn()) {
        await _dio.delete(
          "${Constants.TASKS_RECORDS_URL}:$id",
          options: Options(
            headers: {"Authorization": "Bearer ${AuthManager.getToken()}"},
          ),
        );
      }
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
