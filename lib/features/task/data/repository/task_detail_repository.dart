import 'package:dartz/dartz.dart';
import 'package:taskom/features/task/data/models/category.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/features/task/data/util/failure.dart';

abstract class TaskDetailRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();

  Future<Either<Failure, Category>> getCatgeory(String id);

  Future<Either<Failure, List<Gallery>>> getAllGallery();

  Future<Either<Failure, Gallery>> getGallery(String id);
}
