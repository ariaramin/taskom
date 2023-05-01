import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:taskom/core/util/api_exception.dart';
import 'package:taskom/core/util/failure.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/category/data/datasource/category_datasource.dart';
import 'package:taskom/features/category/data/models/category.dart';
import 'package:taskom/features/category/data/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDatasource _datasource = locator.get();

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
}
