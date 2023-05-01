import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/extentions/datetime_extention.dart';
import 'package:taskom/config/util/filter.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';
import 'package:taskom/features/task/domain/usecase/add_task.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks_date.dart';
import 'package:taskom/features/task/domain/usecase/update_task.dart';
import 'package:taskom/features/task/domain/usecase/update_task_status.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_event.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasks _getAllTasks = locator.get();
  final GetAllTasksDate _getAllTasksDate = locator.get();
  final AddTask _addTask = locator.get();
  final UpdateTask _updateTask = locator.get();
  final UpdateTaskStatus _updateTaskStatus = locator.get();

  TaskBloc() : super(TaskInitState()) {
    on<TaskListRequestEvent>(
      (event, emit) async {
        if (state is! TaskListResponse) {
          emit(TaskLoadingState());
        }
        var taskList = await _getAllTasks.call(event.taskListParams);
        var dateList = await _getAllTasksDate.call();
        emit(TaskListResponse(
          taskList: taskList,
          dateList: dateList,
        ));
      },
    );

    on<AddTaskRequestEvent>(
      (event, emit) async {
        emit(TaskLoadingState());
        var response = await _addTask.call(event.taskParams);
        emit(TaskResponse(response: response));
        // add(TaskListRequestEvent());
      },
    );

    on<UpdateTaskRequestEvent>(
      (event, emit) async {
        emit(TaskLoadingState());
        var response = await _updateTask.call(event.taskParams);
        emit(TaskResponse(response: response));
      },
    );

    on<UpdateTaskStatusRequestEvent>(
      (event, emit) async {
        var response =
            await _updateTaskStatus.call(event.updateTaskStatusParams);
        // emit(TaskResponse(response: response));
        // var taskList = await _getAllTasks.call(
        //   TaskListParams(
        //     filter: Filter(
        //         filterSequence:
        //             "date ~ '${event.taskParams!.taskModel.dateTime!.getGregorianDate()}'"),
        //   ),
        // );
        // var dateList = await _getAllTasksDate.call();
        // emit(TaskListResponse(
        //   taskList: taskList,
        //   dateList: dateList,
        // ));
        add(TaskListRequestEvent(
          taskListParams: TaskListParams(
            filter: Filter(
                filterSequence:
                    "date ~ '${DateTime.now().getGregorianDate()}'"),
          ),
        ));
      },
    );
  }
}
