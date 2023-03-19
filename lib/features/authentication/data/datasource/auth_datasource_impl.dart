import 'package:dio/dio.dart';
import 'package:taskom/config/util/auth_exception.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/datasource/auth_datasource.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio = locator.get();

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post(
        "collections/users/auth-with-password",
        data: {
          "identity": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data?["token"];
      }
    } on DioError catch (error) {
      throw AuthException(
        error.response?.statusCode,
        error.response?.data["data"],
      );
    } catch (_) {
      rethrow;
    }
    return "";
  }

  @override
  Future<void> register(
    String username,
    String email,
    String password,
    String avatar,
  ) async {
    try {
      await _dio.post(
        "collections/users/records",
        data: {
          "username": username,
          "email": email,
          "password": password,
          "passwordConfirm": password,
          "avatar": avatar,
        },
      );
    } on DioError catch (error) {
      throw AuthException(
        error.response?.statusCode,
        error.response?.data["data"],
      );
    } catch (_) {
      rethrow;
    }
  }
}
