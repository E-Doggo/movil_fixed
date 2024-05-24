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
      emit(RestaurantLoaded(restaruantInfo: event.resInfo)); // Mock data
    });
  }

  void _init() async {
    try {
      final restaruantInfo = await resRepo.getRestuarantInfo(parameter);
      add(RestaurantFetchedData(resInfo: restaruantInfo));
    } catch (e) {
      emit(RestaurantLoadingFailed());
    }
  }
}
