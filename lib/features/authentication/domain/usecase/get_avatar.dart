import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/repository/profile_repository.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/features/authentication/domain/params/avatar_params.dart';

class GetAvatar extends Usecase<Failure, Avatar> {
  final ProfileRepository _repository = locator.get();

  @override
  Future<Either<Failure, Avatar>> call(Params? params) {
    var avatarParams = params != null ? params as AvatarParams : null;
    return _repository.getAvatar(avatarParams!.avatarId);
  }
}
