import 'dart:io';

import 'package:taskom/config/util/api_exception.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/datasource/profile_datasource.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/config/util/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:taskom/features/authentication/data/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDatasource _datasource = locator.get();

  @override
  Future<Either<Failure, List<Avatar>>> getAllAvatars() async {
    try {
      var response = await _datasource.getAllAvatars();
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }
}
