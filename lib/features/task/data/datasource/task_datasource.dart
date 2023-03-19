import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/config/util/filter.dart';

abstract class TaskDatasource {
  Future<List<TaskModel>> getAllTasks(Filter? filter);

  Future<TaskModel> getTask(String id);

  Future addTask(TaskModel taskModel);

  Future updateTask(TaskModel taskModel);

  Future deleteTask(String id);
}
