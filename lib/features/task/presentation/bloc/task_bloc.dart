import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks_date.dart';
import 'package:taskom/features/task/presentation/bloc/task_event.dart';
import 'package:taskom/features/task/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasks _getAllTasks = locator.get();
  final GetAllTasksDate _getAllTasksDate = locator.get();

  TaskBloc() : super(TaskInitState()) {
    on<TaskListRequestEvent>(
      (event, emit) async {
        emit(TaskLoadingState());
        var taskList = await _getAllTasks.call(event.taskListParams);
        var dateList = await _getAllTasksDate.call();
        emit(TaskListResponse(
          taskList: taskList,
          dateList: dateList,
        ));
      },
    );
  }
}
