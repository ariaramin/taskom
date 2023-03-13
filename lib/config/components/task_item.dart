import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/components/cached_image.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/task/data/models/task.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
        CachedImage(
          imageUrl: widget.task.thumbnail!,
        ),
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
                    style: MSHCheckboxStyle.stroke,
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
            "assets/icons/Edit.svg",
            width: 18,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        AppChip(
          title:
              "${widget.task.dateTime!.hour}:${_getMinute(widget.task.dateTime!)}",
          widget: SvgPicture.asset(
            "assets/icons/Time.svg",
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
