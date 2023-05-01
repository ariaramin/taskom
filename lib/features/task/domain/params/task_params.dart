import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/features/task/data/models/task.dart';

class TaskParams extends Params {
  final TaskModel taskModel;

  TaskParams({required this.taskModel});

  @override
  List<Object?> get props => [];
}
