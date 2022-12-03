import 'package:flutter/material.dart';
import 'package:taskom/constants/constants.dart';
import 'package:taskom/models/task_type.dart';

class TaskTypeWidget extends StatelessWidget {
  TaskType taskType;
  int index;
  int selectedItem;

  TaskTypeWidget(
      {super.key,
      required this.taskType,
      required this.index,
      required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 138,
      decoration: BoxDecoration(
        // color: whiteColor,
        border: Border.all(
          width: 2,
          color: (selectedItem == index) ? primaryColor : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
