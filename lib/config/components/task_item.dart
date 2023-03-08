import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:taskom/config/components/app_chip.dart';
import 'package:taskom/config/theme/app_colors.dart';
import 'package:taskom/features/task/data/models/task.dart';

class TaskItem extends StatefulWidget {
  // final TaskModel task;

  const TaskItem({
    super.key,
    // required this.task,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _isChecked = widget.task.isDone ?? false;
  // }

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
        // Image.asset(widget.task.taskType.image),
        Image.asset("assets/images/focus.png"),
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
                    // widget.task.title,
                    "تمرین زبان انگلیسی",
                    style: TextStyle(
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
                // widget.task.subTitle,
                "تمرین کتاب آموزشگاه",
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
        // AppChip(title:  "${convertToPersianNumber(widget.task.time.hour)}:${_getMinute(widget.task.time)}"),
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
          title: "۱۰:۳۰",
          widget: SvgPicture.asset(
            "assets/icons/Time.svg",
            width: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // String _getMinute(TimeOfDay time) {
  //   return time.minute < 10
  //       ? '۰${convertToPersianNumber(time.minute)}'
  //       : convertToPersianNumber(time.minute);
  // }
}
