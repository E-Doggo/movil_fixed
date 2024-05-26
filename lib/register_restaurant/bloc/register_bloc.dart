import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/maps_screen/repository/maps_repository.dart';
import 'package:proyecto_progra_movil/register_restaurant/bloc/register_event.dart';
import 'package:proyecto_progra_movil/register_restaurant/bloc/register_state.dart';
import 'package:proyecto_progra_movil/register_restaurant/repository/register_repository.dart';

class RegisterResBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterResRepo registerRepo;
  MapRepo mapRepo;

  RegisterResBloc({required this.registerRepo, required this.mapRepo})
      : super(RegisterLoading()) {
    on<RegisterMapLoaded>((event, emit) {
      emit(RegisterLoaded(latLng: event.latLng));
    });

    on<RegisterNextStep>((event, emit) async {
      if (event.type == 0) {
        emit(RegisterLoading());
      } else {}
    });

    on<RegisterRestaurant>((event, emit) async {
      try {
        await registerRepo.passwordValidation(
            event.password,
            event.passwordValidation,
            event.email,
            event.restaurantName,
            event.streetName,
            event.description,
            event.coords);
        emit(RegisterSuccesful());
      } catch (e) {
        emit(RegisterFailure(latLng: event.coords));
      }
    });
  }

  Future<void> _init() async {
    await mapRepo.initializeLocationAndSave();
    final LatLng coords = await mapRepo.getLatLngFromSharedPrefs();
    add(RegisterMapLoaded(latLng: coords));
  }
}
