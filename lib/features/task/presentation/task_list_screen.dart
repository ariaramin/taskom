import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/task/presentation/widgets/task_list_body.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: const Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: TaskListBody(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          child: SvgPicture.asset(
            "assets/icons/Add.svg",
            width: 22,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
