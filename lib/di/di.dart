import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/datasource/task_datasource_impl.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource_impl.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository_impl.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';
import 'package:taskom/features/task/data/repository/task_repository_impl.dart';

var locator = GetIt.instance;

Future initGetIt() async {
  // dio
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: Constants.BASE_URL)),
  );

  // shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  // datasource
  locator.registerFactory<TaskDatasource>(() => TaskDatasourceImpl());
  locator
      .registerFactory<TaskDetailDatasource>(() => TaskDetailDatasourceImpl());

  // repository
  locator.registerFactory<TaskRepository>(() => TaskRepositoryImpl());
  locator
      .registerFactory<TaskDetailRepository>(() => TaskDetailRepositoryImpl());
}
