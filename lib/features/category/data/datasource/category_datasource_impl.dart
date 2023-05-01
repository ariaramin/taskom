import 'package:dio/dio.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/core/util/api_exception.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/category/data/datasource/category_datasource.dart';
import 'package:taskom/features/category/data/models/category.dart';

class CategoryDatasourceImpl extends CategoryDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Category>> getAllCategories() async {
    try {
      var response = await _dio.get(Constants.CATEGORIES_RECORDS_URL);
      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Category> getCategory(String id) async {
    try {
      var response = await _dio.get(
        Constants.CATEGORIES_RECORDS_URL,
        queryParameters: {
          "filter": "id='$id'",
        },
      );
      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList()[0];
    } on DioError catch (error) {
      throw ApiException(
        code: error.response?.statusCode,
        message: error.response?.data["message"],
      );
    } catch (_) {
      rethrow;
    }
  }
}
