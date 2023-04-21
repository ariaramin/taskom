import 'package:dartz/dartz.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/config/util/failure.dart';

abstract class TaskDetailRepository {
  Future<Either<Failure, List<Gallery>>> getGallery();
}
