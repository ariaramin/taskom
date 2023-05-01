import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/features/task/domain/params/update_task_status_params.dart';

class UpdateTaskStatus extends Usecase<Failure, String> {
  final TaskRepository _repository = locator.get();

  @override
  Future<Either<Failure, String>> call(Params? params) {
    var updateTaskStatusParams =
        params != null ? params as UpdateTaskStatusParams : null;
    return _repository.updateTaskStatus(
        updateTaskStatusParams!.id, updateTaskStatusParams.status);
  }
}
