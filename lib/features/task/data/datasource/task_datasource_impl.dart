import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskom/features/task/data/util/db_exception.dart';

class TaskDatasourceImpl extends TaskDatasource {
  var _taskBox = Hive.box<TaskModel>(Constants.DATABASE_BOX);

  @override
  List<TaskModel> getAllTasks() {
    try {
      final data = _taskBox.values;
      if (data.isEmpty) {
        throw DbException.noRecords();
      }
      return data.toList().cast<TaskModel>();
    } catch (_) {
      rethrow;
    }
  }

  @override
  TaskModel getTask(String id) {
    try {
      final data = _taskBox.get(id);
      if (data == null) {
        throw DbException.noRecords();
      }
      return data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future addUpdateTask(String id, TaskModel item) async {
    try {
      await _taskBox.put(id, item);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deleteTask(String id) async {
    try {
      await _taskBox.delete(id);
    } catch (_) {
      rethrow;
    }
  }
}
