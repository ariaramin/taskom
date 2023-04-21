import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/category/presentation/bloc/category_bloc.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_bloc.dart';
import 'package:taskom/features/task/presentation/widgets/task_body.dart';

class TaskScreen extends StatelessWidget {
  final TaskModel? task;
  const TaskScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(),
        ),
        BlocProvider(
          create: (context) => TaskDetailBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: TaskBody(taskModel: task),
        ),
      ),
    );
  }
}
