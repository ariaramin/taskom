import 'package:dio/dio.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/task/data/datasource/task_detail_datasource.dart';
import 'package:taskom/features/task/data/models/gallery.dart';
import 'package:taskom/config/util/api_exception.dart';

class TaskDetailDatasourceImpl extends TaskDetailDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Gallery>> getGallery() async {
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
}
