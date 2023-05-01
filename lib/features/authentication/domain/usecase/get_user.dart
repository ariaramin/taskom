import 'package:dartz/dartz.dart';
import 'package:taskom/core/usecase/usecase.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/models/user.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository.dart';

class GetUser extends Usecase<Failure, User> {
  final AuthRepository _repository = locator.get();

  @override
  Future<Either<Failure, User>> call(Params? params) async {
    return await _repository.getUser();
  }
}
