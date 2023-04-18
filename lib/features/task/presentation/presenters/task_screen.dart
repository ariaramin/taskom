import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/features/category/presentation/bloc/category_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_bloc.dart';
import 'package:taskom/features/task/presentation/widgets/task_body.dart';

class TaskScreen extends StatelessWidget {
  // final String taskId;
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
      ],
      child: const Scaffold(
        body: SafeArea(
          child: TaskBody(),
        ),
      ),
    );
  }
}
