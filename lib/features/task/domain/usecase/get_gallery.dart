import 'package:dartz/dartz.dart';
import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository.dart';

class GetGallery extends Usecase<Failure, List<Gallery>> {
  final TaskDetailRepository _repository = locator.get();

  @override
  Future<Either<Failure, List<Gallery>>> call(Params? params) {
    return _repository.getGallery();
  }
}
