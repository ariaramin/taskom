import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskom/models/task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 3)
class TaskModel extends HiveObject {
  TaskModel({
    required this.title,
    required this.subTitle,
    this.isDone = false,
    required this.time,
    required this.taskType,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String subTitle;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  TimeOfDay time;

  @HiveField(4)
  TaskType taskType;
}
