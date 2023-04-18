import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/category/data/models/category.dart';
import 'package:taskom/features/category/data/repository/category_repository.dart';
import 'package:taskom/config/util/failure.dart';

class GetAllCategories extends Usecase<Failure, List<Category>> {
  final CategoryRepository _repository = locator.get();

  @override
  Future<Either<Failure, List<Category>>> call(Params? params) {
    return _repository.getAllCategories();
  }
}
