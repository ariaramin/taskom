import 'package:dartz/dartz.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/category/data/models/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();

  Future<Either<Failure, Category>> getCatgeory(String id);
}
