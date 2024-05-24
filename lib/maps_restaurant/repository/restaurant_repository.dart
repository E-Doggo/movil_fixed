import 'package:proyecto_progra_movil/maps_restaurant/datasource/restaurant_data_source.dart';

class RestaurantRepo {
  RestaurantData resDataSource;
  RestaurantRepo({required this.resDataSource});

  Future getRestuarantInfo(String id) async {
    try {
      return await resDataSource.getAllRestuarantInfo(id);
    } catch (e) {
      Exception("Couldnt fethc the restuarant info");
    }
  }
}
