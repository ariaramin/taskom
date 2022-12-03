import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:taskom/constants/constants.dart';
import 'package:taskom/screen/edit_task_screen.dart';
import 'package:taskom/utility/utility.dart';

import '../models/task.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget(this.task, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
          widget.task.isDone = _isChecked;
          widget.task.save();
        });
      },
      child: Container(
        width: double.infinity,
        height: 132,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: _getContent(),
        ),
      ),
    );
  }

  Widget _getContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MSHCheckbox(
                    size: 28,
                    value: _isChecked,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: greenColor,
                    ),
                    style: MSHCheckboxStyle.fillScaleCheck,
                    onChanged: (selected) {},
                  ),
                  Text(
                    widget.task.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // _getTitle(),
                ],
              ),
              Text(
                widget.task.subTitle,
                style: TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              _getButtons(),
            ],
          ),
        ),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Widget _getButtons() {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${convertToPersianNumber(widget.task.time.hour)}:${_getMinute(widget.task.time)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Iconsax.clock,
                    size: 20,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(widget.task),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: primaryLightColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ویرایش",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Iconsax.edit,
                    size: 20,
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getMinute(TimeOfDay time) {
    return time.minute < 10
        ? '۰${convertToPersianNumber(time.minute)}'
        : convertToPersianNumber(time.minute);
  }
}
