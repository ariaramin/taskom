import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/models/user.dart';

abstract class AuthDatasource {
  Future<String> register(
    String fullName,
    String email,
    String password,
  );

  Future<String> login(
    String email,
    String password,
  );

  Future<void> updateUser(
    String id,
    String? fullName,
    String? email,
    String? password,
    Avatar? avatar,
  );

  Future<User> getUser();
}
