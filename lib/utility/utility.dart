import 'package:taskom/models/task_type.dart';
import 'package:taskom/models/task_type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
      image: "images/focus.png",
      title: "تمرکز",
      taskTypeEnum: TaskTypeEnum.foucs,
    ),
    TaskType(
      image: "images/workout.png",
      title: "ورزش",
      taskTypeEnum: TaskTypeEnum.workout,
    ),
    TaskType(
      image: "images/working.png",
      title: "کار",
      taskTypeEnum: TaskTypeEnum.working,
    ),
    TaskType(
      image: "images/meeting.png",
      title: "جلسه",
      taskTypeEnum: TaskTypeEnum.meeting,
    ),
    TaskType(
      image: "images/date.png",
      title: "ملاقات",
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      image: "images/studying.png",
      title: "مطالعه",
      taskTypeEnum: TaskTypeEnum.studying,
    ),
    TaskType(
      image: "images/party.png",
      title: "مهمونی",
      taskTypeEnum: TaskTypeEnum.party,
    ),
    TaskType(
      image: "images/meditation.png",
      title: "مدیتیشن",
      taskTypeEnum: TaskTypeEnum.meditation,
    ),
  ];

  return list;
}

convertToPersianNumber(int number) {
  String num = number.toString();
  Map<String, String> hashMap = {
    "0": "۰",
    "1": "۱",
    "2": "۲",
    "3": "۳",
    "4": "۴",
    "5": "۵",
    "6": "۶",
    "7": "۷",
    "8": "۸",
    "9": "۹",
  };

  for (var key in hashMap.keys.toList()) {
    num = num.replaceAll(key, hashMap[key]!);
  }

  return num;
}
