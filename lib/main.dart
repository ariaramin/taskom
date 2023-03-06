import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/theme/app_theme.dart';
import 'package:taskom/config/theme/theme_provider.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/models/task.dart';
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
  await Hive.openBox<TaskModel>(Constants.DATABASE_BOX);
  await InitGetIt();
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
            home: Scaffold(
              body: Center(
                child: HomeScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}
