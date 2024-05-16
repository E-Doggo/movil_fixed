import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';

class RegDataSource {
  Future<User?> createUserAuth(String email, String password) async {
    final FireBaseAuthService auth = FireBaseAuthService();
    try {
      await auth.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      throw Exception('Failed to authenticate user data: $e');
    }
  }

  Future<void> saveUserDB(
      String username, String email, String street, String description) async {
    final FireStore DB = FireStore();

    if (street.isNotEmpty && description.isNotEmpty) {
      try {
        await DB.uploadRestaurant(username, email, street, description);
      } catch (e) {
        throw Exception("couldn't upload restaurant found ${e.toString()}");
      }
    } else {
      try {
        await DB.uploadUser(username, email);
      } catch (e) {
        throw Exception("couldn't upload user found ${e.toString()}");
      }
    }
  }
}
