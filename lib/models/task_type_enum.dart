import 'package:hive_flutter/hive_flutter.dart';
part 'task_type_enum.g.dart';

@HiveType(typeId: 5)
enum TaskTypeEnum {
  @HiveField(0)
  working,

  @HiveField(1)
  meeting,

  @HiveField(2)
  foucs,

  @HiveField(3)
  meditation,

  @HiveField(4)
  studying,

  @HiveField(5)
  workout,

  @HiveField(6)
  party,

  @HiveField(7)
  date
}
