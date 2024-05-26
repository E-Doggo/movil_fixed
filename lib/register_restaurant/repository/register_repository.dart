import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/register_restaurant/data_source/register_data_source.dart';

class RegisterResRepo {
  RegResDataSource dataSource;

  RegisterResRepo({required this.dataSource});

  Future<User?> passwordValidation(
    String pass,
    String passValidation,
    String email,
    String username,
    String street,
    String description,
    LatLng coords,
  ) async {
    if (pass == passValidation) {
      await dataSource.createUserAuth(email, pass);
      await dataSource.saveResDB(username, email, street, description, coords);
    }
  }
}
