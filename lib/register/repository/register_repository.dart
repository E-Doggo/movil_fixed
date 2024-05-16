import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_progra_movil/register/data_source/register_data_source.dart';

class RegisterRepo {
  RegDataSource dataSource;

  RegisterRepo({required this.dataSource});

  Future<User?> passwordValidation(
    String pass,
    String passValidation,
    String email,
    String username, {
    String street = "",
    String description = "",
  }) async {
    if (pass == passValidation) {
      await dataSource.createUserAuth(email, pass);
      await dataSource.saveUserDB(username, email, street, description);
    
    }
  }
}
