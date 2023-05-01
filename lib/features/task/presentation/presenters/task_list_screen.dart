import 'package:flutter/material.dart';
import 'package:taskom/features/task/presentation/widgets/task_list_body.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: TaskListBody(),
      ),
    );
  }
}
