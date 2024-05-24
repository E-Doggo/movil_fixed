import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';

class RestaurantData {
  Future<dynamic> getAllRestuarantInfo(String id) async {
    FireStore _fireStore = FireStore();
    try {
      final Map<String, dynamic>? restaurantInfo =
          await _fireStore.getRestaurantById(id);
      return restaurantInfo;
    } catch (e) {
      Exception("Error couldnt fetch $e");
    }
  }
}
