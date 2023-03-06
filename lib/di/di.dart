import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/datasource/task_datasource_impl.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';
import 'package:taskom/features/task/data/repository/task_repository_impl.dart';

var locator = GetIt.instance;

Future<void> InitGetIt() async {
  // shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  // datasource
  locator.registerFactory<TaskDatasource>(() => TaskDatasourceImpl());

  // repository
  locator.registerFactory<TaskRepository>(() => TaskRepositoryImpl());
}
