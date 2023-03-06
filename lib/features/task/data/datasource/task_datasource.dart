import 'package:taskom/features/task/data/models/task.dart';

abstract class TaskDatasource {
  List<TaskModel> getAllTasks();

  TaskModel getTask(String id);

  Future addUpdateTask(String id, TaskModel item);

  Future deleteTask(String id);
}
