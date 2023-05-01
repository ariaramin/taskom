import 'package:dartz/dartz.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/task/data/models/gallery.dart';

abstract class TaskDetailRepository {
  Future<Either<Failure, List<Gallery>>> getGallery();
}
