import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/config/util/filter.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/search/presentation/bloc/search_event.dart';
import 'package:taskom/features/search/presentation/bloc/search_state.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';
import 'package:taskom/features/task/domain/usecase/get_all_tasks.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetAllTasks _getAllTasks = locator.get();

  SearchBloc() : super(SearchInitState()) {
    on<SearchRequest>(
      (event, emit) async {
        emit(SearchLoadingState());
        var filter = Filter(
            filterSequence:
                "title~'${event.text}' || note~'${event.text}' || category.title~'${event.text}'");
        var taskParams = TaskListParams(filter: filter);
        var taskList = await _getAllTasks.call(taskParams);
        emit(SearchResponseState(taskList: taskList));
      },
    );
  }
}
