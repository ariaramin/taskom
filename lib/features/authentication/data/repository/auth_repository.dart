import 'package:dartz/dartz.dart';
import 'package:taskom/config/util/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register(
    String fullName,
    String email,
    String password,
  );

  Future<Either<Failure, String>> login(
    String email,
    String password,
  );
}
