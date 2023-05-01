import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/core/util/api_exception.dart';
import 'package:taskom/core/util/auth_exception.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/datasource/auth_datasource.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/models/user.dart';
import 'package:taskom/features/authentication/data/repository/auth_repository.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource = locator.get();

  @override
  Future<Either<Failure, String>> login(
    String email,
    String password,
  ) async {
    try {
      var token = await _datasource.login(email, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right(Constants.LOGIN_SUCCESS_MESSAGE);
      } else {
        return left(Failure.serverFailure(Constants.ERROR_MESSAGE));
      }
    } on AuthException catch (ex) {
      return left(
          AuthFailure(message: Constants.AUTH_ERROR_MESSAGE, error: ex.error));
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      var userId = await _datasource.register(fullName, email, password);
      if (userId.isNotEmpty) {
        AuthManager.saveUserId(userId);
        var loginResponse = await login(email, password);
        return loginResponse.fold(
            (l) =>
                left(Failure.serverFailure(Constants.REGISTER_ERROR_MESSAGE)),
            (r) => right(Constants.REGISTER_SUCCESS_MESSAGE));
      } else {
        return left(Failure.serverFailure(Constants.ERROR_MESSAGE));
      }
    } on AuthException catch (ex) {
      return left(AuthFailure(
          message: Constants.REGISTER_ERROR_MESSAGE, error: ex.error));
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateUser(
    String id,
    String? fullName,
    String? email,
    String? password,
    Avatar? avatar,
  ) async {
    try {
      await _datasource.updateUser(
        id,
        fullName,
        email,
        password,
        avatar,
      );
      return right(Constants.PROFILE_UPDATED_SUCCESS_MESSAGE);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      var user = await _datasource.getUser();
      if (user.token != null && user.token!.isNotEmpty) {
        AuthManager.saveToken(user.token!);
        return right(user);
      } else {
        return left(Failure.serverFailure(Constants.ERROR_MESSAGE));
      }
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }
}
