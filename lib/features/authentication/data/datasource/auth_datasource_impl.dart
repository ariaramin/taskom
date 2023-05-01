import 'package:dio/dio.dart';
import 'package:taskom/core/constants/constants.dart';
import 'package:taskom/core/util/api_exception.dart';
import 'package:taskom/core/util/auth_exception.dart';
import 'package:taskom/di/di.dart';
import 'package:taskom/features/authentication/data/datasource/auth_datasource.dart';
import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/models/user.dart';
import 'package:taskom/features/authentication/data/util/auth_manager.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio = locator.get();

  @override
  Future<String> login(String email, String password) async {
    try {
      var response = await _dio.post(
        Constants.AUTH_WITH_PASS_URL,
        data: {
          "identity": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data?["token"];
      }
      return "";
    } on DioError catch (error) {
      throw AuthException(
        error.response?.statusCode,
        error.response?.data["data"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      var response = await _dio.post(
        Constants.USERS_RECORDS_URL,
        data: {
          "name": fullName,
          "email": email,
          "password": password,
          "passwordConfirm": password,
        },
      );
      if (response.statusCode == 200) {
        return response.data?["id"];
      }
      return "";
    } on DioError catch (error) {
      throw AuthException(
        error.response?.statusCode,
        error.response?.data["data"],
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(
    String id,
    String? fullName,
    String? email,
    String? password,
    Avatar? avatar,
  ) async {
    try {
      var formData = FormData.fromMap({
        "name": fullName,
        "email": email,
        "password": password,
        "passwordConfirm": password,
      });
      if (avatar != null) {
        formData = FormData.fromMap({
          "name": fullName,
          "email": email,
          "password": password,
          "passwordConfirm": password,
          "avatar": await MultipartFile.fromFile(await avatar.urlToFile()),
        });
      }
      if (AuthManager.isLogedIn()) {
        await _dio.patch(
          "${Constants.USERS_RECORDS_URL}/$id",
          options: Options(
            headers: {"Authorization": AuthManager.getToken()},
          ),
          data: formData,
        );
      }
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
  Future<User> getUser() async {
    try {
      if (AuthManager.isLogedIn()) {
        var response = await _dio.post(
          Constants.AUTH_REFRESH_URL,
          options: Options(
            headers: {"Authorization": AuthManager.getToken()},
          ),
        );
        if (response.statusCode == 200) {
          var user = User.fromMapJson(response.data?["record"]);
          user.token = response.data?["token"];
          return user;
        }
      }
      return User();
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
