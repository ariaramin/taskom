import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository.dart';

class UpdateUserParams extends Params {
  final String id;
  final String? fullName, email, password;
  final Avatar? avatar;

  UpdateUserParams({
    required this.id,
    this.fullName,
    this.email,
    this.password,
    this.avatar,
  });

  @override
  List<Object?> get props => [id, fullName, email, password, avatar];
}

class UpdateUser extends Usecase<Failure, String> {
  final AuthRepository _repository = locator.get();

  @override
  Future<Either<Failure, String>> call(Params? params) async {
    var updateProfileParams = params as UpdateUserParams;
    return await _repository.updateUser(
      updateProfileParams.id,
      updateProfileParams.fullName,
      updateProfileParams.email,
      updateProfileParams.password,
      updateProfileParams.avatar,
    );
  }
}
