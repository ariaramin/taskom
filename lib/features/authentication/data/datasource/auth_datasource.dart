import 'package:taskom/features/authentication/data/models/avatar.dart';
import 'package:taskom/features/authentication/data/models/user.dart';

abstract class AuthDatasource {
  Future<void> register(
    String username,
    String email,
    String password,
    Avatar avatar,
  );

  Future<String> login(
    String email,
    String password,
  );

  Future<User> getUser();
}