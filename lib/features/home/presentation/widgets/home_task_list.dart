import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/core/components/task_list.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_state.dart';

class HomeTaskList extends StatelessWidget {
  final Function(int taskListLength) onResponseRetrieved;

  const HomeTaskList({
    Key? key,
    required this.onResponseRetrieved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskListResponse) {
          state.taskList.fold((l) => 0, (response) {
            onResponseRetrieved(response.length);
          });
        }
      },
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is TaskListResponse) {
          return state.taskList.fold((failure) {
            return SliverToBoxAdapter(
              child: Center(child: Text(failure.message)),
            );
          }, (response) {
            return response.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Text(Constants.NO_TASK_FOR_TODAY_MESSAGE),
                    ),
                  )
                : TaskList(taskList: response);
          });
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
