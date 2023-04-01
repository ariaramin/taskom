import 'package:dartz/dartz.dart';
import 'package:taskom/config/usecase/usecase.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository.dart';

class LoginParams extends Params {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class Login extends Usecase<Failure, String> {
  final AuthRepository _repository = locator.get();

  @override
  Future<Either<Failure, String>> call(Params? params) async {
    var loginParams = params as LoginParams;
    return await _repository.login(
      loginParams.email,
      loginParams.password,
    );
  }
}
