import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/preferences/comida.dart';

class FireStore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadUser(String username, String email) async {
    CollectionReference collRef = _firestore.collection("users");
    await collRef.add({
      "email": email,
      "favorites": [],
      "preferences": [],
      "username": username
    });
  }

  Future<void> uploadPreferences(
      String? email, List<String> preferences) async {
    final CollectionReference collRef = _firestore.collection("users");
    final QuerySnapshot querySnapshot =
        await collRef.where("email", isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        final DocumentReference documentRef = documentSnapshot.reference;

        await documentRef.update({
          "preferences": preferences,
        });
      } catch (e) {
        throw Exception("Error: ${e.toString()}");
      }
    }
  }

  Future<void> uploadRestaurant(
    String resName,
    String email,
    String street,
    String description,
    Map latlng,
    String resID,
    Timestamp openTime,
    Timestamp closingTime,
  ) async {
    List<Map<String, String>> menu = [
      {
        "dish": "Nombre platillo predeterminado",
        "description": "No es un platillo es un perro con chulo",
        "photoURL":
            "https://cc-prod.scene7.com/is/image/CCProdAuthor/What-is-Stock-Photography_P1_mobile",
      },
      {
        "dish": "Nombre platillo predeterminado",
        "description": "No es un platillo es un perro con chulo",
        "photoURL":
            "https://cc-prod.scene7.com/is/image/CCProdAuthor/What-is-Stock-Photography_P1_mobile",
      },
      {
        "dish": "Nombre platillo predeterminado",
        "description": "No es un platillo es un perro con chulo",
        "photoURL":
            "https://cc-prod.scene7.com/is/image/CCProdAuthor/What-is-Stock-Photography_P1_mobile",
      },
      {
        "dish": "Nombre platillo predeterminado",
        "description": "No es un platillo es un perro con chulo",
        "photoURL":
            "https://cc-prod.scene7.com/is/image/CCProdAuthor/What-is-Stock-Photography_P1_mobile",
      },
    ];
    //probably will have to change to float at some point
    CollectionReference collRef = _firestore.collection("restaurants");
    await collRef.add({
      "coordinates": latlng,
      "description": description,
      "email": email,
      "logo": "",
      "name": resName,
      "restaurant_id": resID,
      "street": street,
      "menu": menu,
      "openingTime": openTime,
      "closinTime": closingTime
    });
  }

  Future<List<String>?> getUserPreferencesArray(querySnapshot) async {
    try {
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      final Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('preferences')) {
        final List<dynamic> preferencesData = data['preferences'];
        final List<String> preferences =
            preferencesData.cast<String>().toList();
        return preferences;
      }
      return null;
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

  Future<List<String>?> checkForUserPreferences(String email) async {
    final CollectionReference collRef = _firestore.collection("users");
    final QuerySnapshot querySnapshot =
        await collRef.where("email", isEqualTo: email).get();
    try {
      final listPreferences = getUserPreferencesArray(querySnapshot);
      return listPreferences;
    } catch (e) {
      throw Exception("Couldn't find user in DB");
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurants() async {
    try {
      CollectionReference collRef = _firestore.collection("restaurants");
      QuerySnapshot querySnapshot = await collRef.get();
      List<Map<String, dynamic>> restaurants = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      return restaurants;
    } catch (e) {
      throw Exception("Unknown error couldnt fetch restaurants");
    }
  }

  Future<List<Map<String, dynamic>>> getRestaurantMarker() async {
    final List restaurants = await getRestaurants();
    List<Map<String, dynamic>> latLst = [];
    restaurants.forEach((restaurant) {
      latLst.add({
        "id": restaurant["restaurant_id"],
        "location": restaurant["coordinates"]
      });
    });
    return latLst;
  }

  Future<QuerySnapshot> getCurrentUserDocs() async {
    FireBaseAuthService _auth = FireBaseAuthService();
    CollectionReference collRef = _firestore.collection("users");
    final String? userEmail = await _auth.getCurrentUser();
    QuerySnapshot querySnapshot =
        await collRef.where("email", isEqualTo: userEmail).get();
    return querySnapshot;
  }

  Future<Map<String, dynamic>?> getRestaurantById(String id) async {
    CollectionReference collRef = _firestore.collection("restaurants");
    QuerySnapshot querySnapshot =
        await collRef.where("restaurant_id", isEqualTo: id).get();

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        return documentSnapshot.data() as Map<String, dynamic>?;
      } catch (e) {
        throw Exception("Error: ${e.toString()}");
      }
    }
  }

  Future<void> addResToFavs(String idRestaurant) async {
    QuerySnapshot querySnapshot = await getCurrentUserDocs();

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        final DocumentReference documentRef = documentSnapshot.reference;

        await documentRef.update({
          "favorites": FieldValue.arrayUnion([idRestaurant]),
        });
      } catch (e) {
        throw Exception("Error: ${e.toString()}");
      }
    }
  }

  Future<void> deleteResFromFavs(String idRestaurant) async {
    QuerySnapshot querySnapshot = await getCurrentUserDocs();

    if (querySnapshot.docs.isNotEmpty) {
      try {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        final DocumentReference documentRef = documentSnapshot.reference;

        await documentRef.update({
          "favorites": FieldValue.arrayRemove([idRestaurant]),
        });
      } catch (e) {
        throw Exception("Error: ${e.toString()}");
      }
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    QuerySnapshot querySnapshot = await getCurrentUserDocs();
    if (querySnapshot.docs.isNotEmpty) {
      try {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        return documentSnapshot.data() as Map<String, dynamic>?;
      } catch (e) {
        throw Exception("Error: ${e.toString()}");
      }
    }
  }
}
