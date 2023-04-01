import 'package:dartz/dartz.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register(
    String username,
    String email,
    String password,
    Avatar avatar,
  );

  Future<Either<Failure, String>> login(
    String email,
    String password,
  );
}
