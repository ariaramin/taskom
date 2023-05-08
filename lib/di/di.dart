import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskom/config/theme/theme_provider.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/features/authentication/data/datasource/auth_datasource.dart';
import 'package:taskom/features/authentication/data/datasource/auth_datasource_impl.dart';
import 'package:taskom/features/authentication/data/datasource/profile_datasource.dart';
import 'package:taskom/features/authentication/data/datasource/profile_datasource_impl.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:taskom/features/authentication/data/repository/profile_repository.dart';
import 'package:taskom/features/authentication/data/repository/profile_repository_impl.dart';
import 'package:taskom/features/authentication/domain/usecase/get_all_avatars.dart';
import 'package:taskom/features/authentication/domain/usecase/get_user.dart';
import 'package:taskom/features/authentication/domain/usecase/login.dart';
import 'package:taskom/features/authentication/domain/usecase/register.dart';
import 'package:taskom/features/authentication/domain/usecase/update_user.dart';
import 'package:taskom/features/category/data/datasource/category_datasource.dart';
import 'package:taskom/features/category/data/datasource/category_datasource_impl.dart';
import 'package:taskom/features/category/data/repository/category_repository.dart';
import 'package:taskom/features/category/data/repository/category_repository_impl.dart';
import 'package:taskom/features/task/data/datasource/task_datasource.dart';
import 'package:taskom/features/task/data/datasource/task_datasource_impl.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource_impl.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository_impl.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';
import 'package:taskom/features/task/data/repository/task_repository_impl.dart';
import 'package:taskom/features/category/domain/usecase/get_all_categories.dart';
import 'package:taskom/features/task/domain/usecase/add_task.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks_date.dart';
import 'package:taskom/features/task/domain/usecase/get_gallery.dart';
import 'package:taskom/features/task/domain/usecase/update_task.dart';
import 'package:taskom/features/task/domain/usecase/update_task_status.dart';
import 'package:taskom/features/task/presentation/bloc/task/task_bloc.dart';

var locator = GetIt.instance;

Future initGetIt() async {
  // shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  // theme provider
  locator.registerSingleton<ThemeProvider>(ThemeProvider());

  // dio
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: Constants.BASE_URL)),
  );

  // datasource
  locator.registerFactory<TaskDatasource>(() => TaskDatasourceImpl());
  locator
      .registerFactory<TaskDetailDatasource>(() => TaskDetailDatasourceImpl());
  locator.registerFactory<CategoryDatasource>(() => CategoryDatasourceImpl());
  locator.registerFactory<ProfileDatasource>(() => ProfileDatasourceImpl());
  locator.registerFactory<AuthDatasource>(() => AuthDatasourceImpl());

  // repository
  locator.registerFactory<TaskRepository>(() => TaskRepositoryImpl());
  locator
      .registerFactory<TaskDetailRepository>(() => TaskDetailRepositoryImpl());
  locator.registerFactory<CategoryRepository>(() => CategoryRepositoryImpl());
  locator.registerFactory<ProfileRepository>(() => ProfileRepositoryImpl());
  locator.registerFactory<AuthRepository>(() => AuthRepositoryImpl());

  // usecase
  locator.registerFactory<GetAllCategories>(() => GetAllCategories());
  locator.registerFactory<GetAllTasks>(() => GetAllTasks());
  locator.registerFactory<GetAllTasksDate>(() => GetAllTasksDate());
  locator.registerFactory<GetAllAvatars>(() => GetAllAvatars());
  locator.registerFactory<Login>(() => Login());
  locator.registerFactory<Register>(() => Register());
  locator.registerFactory<UpdateUser>(() => UpdateUser());
  locator.registerFactory<GetUser>(() => GetUser());
  locator.registerFactory<GetGallery>(() => GetGallery());
  locator.registerFactory<AddTask>(() => AddTask());
  locator.registerFactory<UpdateTask>(() => UpdateTask());
  locator.registerFactory<UpdateTaskStatus>(() => UpdateTaskStatus());

  // bloc
  locator.registerSingleton<TaskBloc>(TaskBloc());
}
