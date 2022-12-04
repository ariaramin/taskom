import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskom/constants/constants.dart';
import 'package:taskom/models/task.dart';
import 'package:taskom/models/task_type.dart';
import 'package:taskom/models/task_type_enum.dart';
import 'package:taskom/screen/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox<Task>("tasks");
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Shabnam",
      ),
      home: Scaffold(
        backgroundColor: greyColor,
        body: Center(
          child: HomeScreen(),
        ),
      ),
    );
  }
}
