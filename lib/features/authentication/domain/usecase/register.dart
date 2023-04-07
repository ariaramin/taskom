import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository.dart';

class RegisterParams extends Params {
  final String username, email, password;

  RegisterParams({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class Register extends Usecase<Failure, String> {
  final AuthRepository _repository = locator.get();

  @override
  Future<Either<Failure, String>> call(Params? params) async {
    var registerParams = params as RegisterParams;
    return await _repository.register(
      registerParams.username,
      registerParams.email,
      registerParams.password,
    );
  }
}
