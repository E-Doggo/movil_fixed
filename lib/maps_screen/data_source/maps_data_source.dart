import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';

class MapDataSource {
  Future getLocationRestaurants() async {
    final FireStore store = FireStore();
    try {
      final response = await store.getRestaurantMarker();
      return response;
    } catch (e) {
      throw Exception('Failed to authenticate user data: $e');
    }
  }
}
