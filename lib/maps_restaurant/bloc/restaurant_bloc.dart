import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_event.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_state.dart';
import 'package:proyecto_progra_movil/maps_restaurant/repository/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepo resRepo;
  final String parameter;

  RestaurantBloc({required this.resRepo, required this.parameter})
      : super(RestaurantLoading()) {
    _init();
    on<RestaurantFetchedData>((event, emit) async {
      emit(RestaurantLoaded(
          restaruantInfo: event.resInfo,
          restaurantFavorite: event.isFavorite)); // Mock data
    });
    on<RestaurantAddFavorite>((event, emit) async {
      try {
        await resRepo.AddResturantFavorite(event.resID);
        emit(RestaurantLoaded(
            restaruantInfo: event.resInfo, restaurantFavorite: true));
      } catch (e) {
        Exception("Couldnt add to favorites due to unknown error");
      }
    });
  }

  void _init() async {
    try {
      final restaruantInfo = await resRepo.getRestuarantInfo(parameter);
      final isFavorite =
          await resRepo.isResFavorite(restaruantInfo["restaurant_id"]);
      add(RestaurantFetchedData(
          resInfo: restaruantInfo, isFavorite: isFavorite));
    } catch (e) {
      emit(RestaurantLoadingFailed());
    }
  }
}
