import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/restaurant_info/bloc/restaurant_event.dart';
import 'package:proyecto_progra_movil/restaurant_info/bloc/restaurant_state.dart';
import 'package:proyecto_progra_movil/restaurant_info/repository/restaurant_repository.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantRepo resRepo;

  RestaurantBloc({required this.resRepo}) : super(RestaurantLoading()) {}
}
