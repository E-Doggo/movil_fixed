import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return user.email;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("No se pudo obtener el usuario actual: ${e.toString()}");
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      throw Exception("couldn't signup user ${e.toString()}");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      throw Exception("couldn't signin user ${e.toString()}");
    }
  }
}
