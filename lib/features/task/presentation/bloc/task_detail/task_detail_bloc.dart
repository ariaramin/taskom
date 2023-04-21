import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/domain/usecase/get_gallery.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_event.dart';
import 'package:taskom/features/task/presentation/bloc/task_detail/task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final GetGallery _getGallery = locator.get();

  TaskDetailBloc() : super(TaskDetailInitState()) {
    on<TaskImageListRequestEvent>(
      (event, emit) async {
        emit(TaskDetailLoadingState());
        var galleryList = await _getGallery.call(null);
        emit(TaskImageListResponse(imageList: galleryList));
      },
    );
  }
}
