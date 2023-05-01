import 'package:dartz/dartz.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/models/user.dart';

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

  Future<Either<Failure, String>> updateUser(
    String id,
    String? fullName,
    String? email,
    String? password,
    Avatar? avatar,
  );

  Future<Either<Failure, User>> getUser();
}
