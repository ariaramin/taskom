import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';

class GetAllTasksDate {
  final TaskRepository _repository = locator.get();

  Future<List<DateTime>> call() async {
    var taskList = await _repository.getAllTasks(null);
    return taskList.fold(
      (failure) => [],
      (response) {
        return response
            .map((element) => element.dateTime!.removeTime())
            .toList();
      },
    );
  }
}
