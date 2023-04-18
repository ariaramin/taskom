import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/components/app_button.dart';
import 'package:taskom/features/category/presentation/bloc/category_bloc.dart';
import 'package:taskom/features/category/presentation/bloc/category_event.dart';
import 'package:taskom/features/task/presentation/bloc/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task_event.dart';
import 'package:taskom/features/task/presentation/widgets/appbar_title.dart';
import 'package:taskom/features/task/presentation/widgets/task_category_list.dart';
import 'package:taskom/features/task/presentation/widgets/task_datetime.dart';
import 'package:taskom/features/task/presentation/widgets/task_form_textfields.dart';
import 'package:taskom/features/task/presentation/widgets/task_image_list.dart';

class TaskBody extends StatefulWidget {
  const TaskBody({super.key});

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryListRequestEvent());
    BlocProvider.of<TaskBloc>(context).add(TaskImageListRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppBarTitle(
                title: "تسکام",
              ),
            ),
            SliverToBoxAdapter(
              child: TaskFormTextFields(),
            ),
            SliverToBoxAdapter(
              child: TaskCategoryList(),
            ),
            SliverToBoxAdapter(
              child: TaskDatetime(),
            ),
            SliverToBoxAdapter(
              child: TaskImageList(),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 82)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            bottom: 18,
          ),
          child: AppButton(
            text: "ثبت",
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
