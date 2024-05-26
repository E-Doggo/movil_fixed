import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';

class RegResDataSource {
  Future<User?> createUserAuth(String email, String password) async {
    final FireBaseAuthService auth = FireBaseAuthService();
    try {
      await auth.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      throw Exception('Failed to authenticate user data: $e');
    }
  }

  Future<void> saveResDB(
    String username,
    String email,
    String street,
    String description,
    LatLng coords,
    Timestamp openTime,
    Timestamp closingTime,
  ) async {
    final FireStore DB = FireStore();
    try {
      final String resID = username.replaceAll(" ", "_");
      Map<String, double> coordinates = {
        "xcoords": coords.longitude,
        "ycoords": coords.latitude,
      };
      await DB.uploadRestaurant(username, email, street, description,
          coordinates, resID, openTime, closingTime);
    } catch (e) {
      throw Exception("couldn't upload restaurant found ${e.toString()}");
    }
  }
}
