import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/home/presentation/bloc/home_event.dart';
import 'package:taskom/features/home/presentation/bloc/home_state.dart';
import 'package:taskom/features/task/domain/usecase/get_all_categories.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllCategories _getAllCategories = locator.get();
  final GetAllTasks _getAllTasks = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeDataRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var categoryList = await _getAllCategories.call(null);
        var taskList = await _getAllTasks.call(event.taskListParams);
        emit(HomeResponseState(
          allCategories: categoryList,
          allTasks: taskList,
        ));
      },
    );
  }
}
