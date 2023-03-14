import 'package:flutter/material.dart';
import 'package:taskom/config/components/task_item.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/features/task/data/models/task.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> taskList;

  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return taskList.isEmpty
        ? const SliverToBoxAdapter(
            child: Center(
              child: Text(Constants.NO_TASK_AT_THIS_TIME_MESSAGE),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: taskList.length,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: TaskItem(
                    task: taskList[index],
                  ),
                );
              },
            ),
          );
  }
}
