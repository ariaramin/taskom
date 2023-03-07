import 'package:dio/dio.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/features/task/data/models/category.dart';
import 'package:taskom/features/task/data/util/api_exception.dart';

class TaskDetailDatasourceImpl extends TaskDetailDatasource {
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

  @override
  Future<List<Gallery>> getAllGallery() async {
    try {
      var response = await _dio.get(Constants.GALLERY_RECORDS_URL);
      return response.data['items']
          .map<Gallery>((jsonObject) => Gallery.fromMapJson(jsonObject))
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
  Future<Gallery> getGallery(String id) async {
    try {
      var response = await _dio.get(
        Constants.GALLERY_RECORDS_URL,
        queryParameters: {
          "filter": "id='$id'",
        },
      );
      return response.data['items']
          .map<Gallery>((jsonObject) => Gallery.fromMapJson(jsonObject))
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
