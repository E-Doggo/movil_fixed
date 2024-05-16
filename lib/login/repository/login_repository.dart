import 'package:proyecto_progra_movil/login/data_source/login_source.dart';

class LoginRepo {
  DataSource loginDataSource;

  LoginRepo({required this.loginDataSource});

  Future<bool> authenticateData(username, password) async {
    try {
      final response =
          await loginDataSource.authenticateUser(username, password);
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to authenticate user data: $e');
    }
  }

  Future<List<String>?> getUserPreferences(username) async {
    try {
      final preferencesList = loginDataSource.getUserPreferences(username);
      return preferencesList;
    } catch (e) {}
  }
}
