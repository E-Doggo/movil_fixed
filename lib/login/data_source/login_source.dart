import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';

class DataSource {
  Future<User?> authenticateUser(String username, String password) async {
    final FireBaseAuthService auth = FireBaseAuthService();
    try {
      final response =
          await auth.signInWithEmailAndPassword(username, password);
      return response;
    } catch (e) {
      throw Exception('Failed to authenticate user data: $e');
    }
  }

  Future<List<String>?> getUserPreferences(String username) async {
    final FireStore firestore = FireStore();
    try {
      final preferences = await firestore.checkForUserPreferences(username);
      return preferences;
    } catch (e) {
      throw Exception("couldn't fetch preferences from firestore");
    }
  }
}
