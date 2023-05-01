import 'package:dartz/dartz.dart';
import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/repository/profile_repository.dart';

class GetAllAvatars extends Usecase<Failure, List<Avatar>> {
  final ProfileRepository _repository = locator.get();

  @override
  Future<Either<Failure, List<Avatar>>> call(Params? params) {
    return _repository.getAllAvatars();
  }
}
