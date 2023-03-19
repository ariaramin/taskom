import 'dart:io';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/features/task/data/models/category.dart';
import 'package:dartz/dartz.dart';
import 'package:taskom/features/task/data/repository/task_detail_repository.dart';
import 'package:taskom/config/util/api_exception.dart';
import 'package:taskom/config/util/failure.dart';

class TaskDetailRepositoryImpl extends TaskDetailRepository {
  final TaskDetailDatasource _datasource = locator.get();

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      var response = await _datasource.getAllCategories();
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, Category>> getCatgeory(String id) async {
    try {
      var response = await _datasource.getCategory(id);
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Gallery>>> getAllGallery() async {
    try {
      var response = await _datasource.getAllGallery();
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }

  @override
  Future<Either<Failure, Gallery>> getGallery(String id) async {
    try {
      var response = await _datasource.getGallery(id);
      return right(response);
    } on ApiException catch (error) {
      return left(Failure.serverFailure(error.message));
    } on SocketException {
      return left(Failure.connectionFailure());
    }
  }
}
