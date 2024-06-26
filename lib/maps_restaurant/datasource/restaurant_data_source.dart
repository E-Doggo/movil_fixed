import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_firestore.dart';

class RestaurantData {
  Future<dynamic> getAllRestuarantInfo(String id) async {
    FireStore _fireStore = FireStore();
    try {
      final Map<String, dynamic>? restaurantInfo =
          await _fireStore.getRestaurantById(id);
      return restaurantInfo;
    } catch (e) {
      throw Exception("Error couldnt fetch $e");
    }
  }

  Future<void> addResToFavs(String idRestaurant) async {
    FireStore _fireStore = FireStore();
    try {
      await _fireStore.addResToFavs(idRestaurant);
    } catch (e) {
      throw Exception("Couldnt add restaurant to user favorites");
    }
  }

  Future<void> deleteFavoriteRestaurant(String idRestaurant) async {
    FireStore _fireStore = FireStore();
    try {
      await _fireStore.deleteResFromFavs(idRestaurant);
    } catch (e) {
      throw Exception("Couldnt add restaurant to user favorites");
    }
  }

  Future<List> getUserFavorites() async {
    FireStore _fireStore = FireStore();
    try {
      final userData = await _fireStore.getUserInfo();
      return userData!["favorites"];
    } catch (e) {
      throw Exception("Couldnt add restaurant to user favorites");
    }
  }
}
