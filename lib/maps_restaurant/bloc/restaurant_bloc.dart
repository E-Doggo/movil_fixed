import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_event.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_state.dart';
import 'package:proyecto_progra_movil/maps_restaurant/repository/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepo resRepo;

  RestaurantBloc({required this.resRepo}) : super(RestaurantLoading()) {
    on<RestaurantFetchedData>((event, emit) async {
      emit(RestaurantLoaded(
          id_restaurant: "1", favorite: false, stars: 4)); // Mock data
    });
    _init();
  }

  void _init() {
    add(RestaurantFetchedData());
  }
}
