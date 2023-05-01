import 'package:taskom/core/util/filter.dart';
import 'package:taskom/features/task/data/models/task.dart';

abstract class TaskDatasource {
  Future<List<TaskModel>> getAllTasks(Filter? filter);

  Future<TaskModel> getTask(String id);

  Future addTask(TaskModel taskModel);

  Future updateTask(TaskModel taskModel);

  Future updateTaskStatus(String id, bool status);

  Future deleteTask(String id);
}
