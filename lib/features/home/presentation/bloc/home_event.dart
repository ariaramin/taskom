import 'package:equatable/equatable.dart';
import 'package:taskom/features/task/domain/params/task_list_params.dart';

abstract class HomeEvent extends Equatable {}

class HomeDataRequestEvent extends HomeEvent {
  final TaskListParams? taskListParams;

  HomeDataRequestEvent({this.taskListParams});

  @override
  List<Object?> get props => [];
}
