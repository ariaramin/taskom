import 'package:flutter/material.dart';
import 'package:taskom/config/components/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 5,
        (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            child: TaskItem(),
          );
        },
      ),
    );
  }
}
