import 'package:dartz/dartz.dart';
import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/models/task.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';

import 'package:taskom/features/task/domain/params/task_list_params.dart';

class GetAllTasks extends Usecase<Failure, List<TaskModel>> {
  final TaskRepository _repository = locator.get();

  @override
  Future<Either<Failure, List<TaskModel>>> call(Params? params) {
    var taskParams = params != null ? params as TaskListParams : null;
    return _repository.getAllTasks(taskParams?.filter);
  }
}
