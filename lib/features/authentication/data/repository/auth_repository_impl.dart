import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/util/api_exception.dart';
import 'package:taskom/config/util/auth_exception.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/datasource/auth_datasource.dart';
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
      await _datasource.register(fullName, email, password);
      return right(Constants.REGISTER_SUCCESS_MESSAGE);
    } on AuthException catch (ex) {
      return left(AuthFailure(
          message: Constants.REGISTER_ERROR_MESSAGE, error: ex.error));
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }
}
