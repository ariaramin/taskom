import 'package:dartz/dartz.dart';
import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/repository/task_repository.dart';
import 'package:taskom/features/task/domain/params/task_params.dart';

class AddTask extends Usecase<Failure, String> {
  final TaskRepository _repository = locator.get();

  @override
  Future<Either<Failure, String>> call(Params? params) {
    var taskParams = params != null ? params as TaskParams : null;
    return _repository.addTask(taskParams!.taskModel);
  }
}
