import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_event.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_state.dart';
import 'package:proyecto_progra_movil/maps_restaurant/repository/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepo resRepo;
  final String parameter;

  RestaurantBloc({required this.resRepo, required this.parameter})
      : super(RestaurantLoading()) {
    on<RestaurantFetchedData>((event, emit) async {
      final restaruantInfo =
          await resRepo.getRestuarantInfo(event.parameter_id);
      emit(RestaurantLoaded(restaruantInfo: restaruantInfo)); // Mock data
    });
    _init();
  }

  void _init() async {
    try {
      await resRepo.getRestuarantInfo(parameter);
      add(RestaurantFetchedData(parameter_id: parameter));
    } catch (e) {
      emit(RestaurantLoadingFailed());
    }
  }
}
