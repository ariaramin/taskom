import 'package:dio/dio.dart';
import 'package:taskom/config/constants/constants.dart';
import 'package:taskom/config/util/api_exception.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/datasource/profile_datasource.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';

class ProfileDatasourceImpl extends ProfileDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<Avatar>> getAllAvatars() async {
    try {
      var response = await _dio.get(Constants.AVATARS_RECORDS_URL);
      return response.data['items']
          .map<Avatar>((jsonObject) => Avatar.fromMapJson(jsonObject))
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
  Future<Avatar> getAvatar(String id) async {
    try {
      var response = await _dio.get(
        Constants.AVATARS_RECORDS_URL,
        queryParameters: {
          "filter": "id='$id'",
        },
      );
      return response.data['items']
          .map<Avatar>((jsonObject) => Avatar.fromMapJson(jsonObject))
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