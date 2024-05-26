import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/maps_screen/repository/maps_repository.dart';
import 'package:proyecto_progra_movil/register/bloc/register_event.dart';
import 'package:proyecto_progra_movil/register/bloc/register_state.dart';
import 'package:proyecto_progra_movil/register/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepo registerRepo;
  MapRepo mapRepo;

  RegisterBloc({required this.registerRepo, required this.mapRepo})
      : super(RegisterWaiting()) {
    on<RegisterSave>((event, emit) async {
      try {
        emit(RegisterValidating());
        await registerRepo.passwordValidation(event.password,
            event.passwordValidation, event.email, event.username);
        emit(RegisterSuccesful());
      } catch (e) {
        emit(RegisterFailure());
      }
    });
  }
}
