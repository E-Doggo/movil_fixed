import 'package:proyecto_progra_movil/maps_restaurant/datasource/restaurant_data_source.dart';

class RestaurantRepo {
  RestaurantData resDataSource;
  RestaurantRepo({required this.resDataSource});

  Future getRestuarantInfo(String id) async {
    try {
      return await resDataSource.getAllRestuarantInfo(id);
    } catch (e) {
      Exception("Couldnt fetch the restuarant info");
    }
  }

  Future<void> AddResturantFavorite(String idRestaurant) async {
    try {
      await resDataSource.addResToFavs(idRestaurant);
    } catch (e) {
      Exception("Couldnt send data to add to favorites");
    }
  }

  Future<bool> isResFavorite(String idRestaurant) async {
    try {
      final favoritesList = await resDataSource.getUserFavorites();
      if (favoritesList.contains(idRestaurant)) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Couldnt fetch the favorite restaurants of user");
    }
  }
}
