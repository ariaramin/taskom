abstract class AuthDatasource {
  Future<void> register(
    String username,
    String email,
    String password,
    String avatar,
  );

  Future<String> login(
    String username,
    String password,
  );
}
