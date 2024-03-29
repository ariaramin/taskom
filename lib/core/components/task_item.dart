import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:taskom/config/route/app_route_names.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/core/components/app_chip.dart';
import 'package:taskom/core/components/cached_image.dart';
import 'package:taskom/core/constants/assets_manager.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/domain/params/update_task_status_params.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_bloc.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_event.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.task.isDone ?? false;
  }

  @override
  void didUpdateWidget(covariant TaskItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isChecked = widget.task.isDone ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<TaskBloc>(context).add(UpdateTaskStatusRequestEvent(
            updateTaskStatusParams: UpdateTaskStatusParams(
                id: widget.task.id!, status: !_isChecked)));
      },
      child: Container(
        width: double.infinity,
        height: 138,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(.3),
              blurRadius: 25,
              spreadRadius: -12,
              offset: const Offset(0, 16),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: _getContent(),
        ),
      ),
    );
  }

  Widget _getContent() {
    return Row(
      children: [
        CachedImage(imageUrl: widget.task.thumbnail!),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.title!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MSHCheckbox(
                    size: 28,
                    value: _isChecked,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: AppColors.successColor,
                    ),
                    style: MSHCheckboxStyle.fillScaleCheck,
                    onChanged: (selected) {},
                  ),
                  // _getTitle(),
                ],
              ),
              Text(
                widget.task.note!,
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.6)),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              _getButtons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppChip(
          title: "ویرایش",
          isLight: true,
          widget: SvgPicture.asset(
            AssetsManager.edit,
            width: 18,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRouteNames.task,
              arguments: widget.task,
            );
          },
        ),
        const SizedBox(
          width: 12,
        ),
        AppChip(
          title:
              "${widget.task.dateTime!.hour}:${_getMinute(widget.task.dateTime!)}",
          widget: SvgPicture.asset(
            AssetsManager.time,
            width: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _getMinute(DateTime time) {
    return time.minute < 10 ? '۰${time.minute}' : "${time.minute}";
  }
}
