import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/models/category.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository.dart';
import 'package:taskom/config/util/failure.dart';

class GetAllCategories extends Usecase<Failure, List<Category>> {
  final TaskDetailRepository _repository = locator.get();

  @override
  Future<Either<Failure, List<Category>>> call(Params? params) {
    return _repository.getAllCategories();
  }
}
