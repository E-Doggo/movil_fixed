import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/register/bloc/register_event.dart';
import 'package:proyecto_progra_movil/register/bloc/register_state.dart';
import 'package:proyecto_progra_movil/register/repository/register_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterRepo registerRepo;

  RegisterBloc({required this.registerRepo}) : super(RegisterWaiting()) {
    on<RegisterSave>((event, emit) async {
      try {
        await registerRepo.passwordValidation(event.password,
            event.passwordValidation, event.email, event.username);
        emit(RegisterSuccesful());
      } catch (e) {
        emit(RegisterFailure());
      }
    });
    on<RegisterChange>((event, emit) {
      if (event.type == 0) {
        emit(RegisterWaiting());
      } else {
        emit(RegisterWaitingRestaurant());
      }
    });

    on<RegisterRestaurant>((event, emit) async {
      try {
        await registerRepo.passwordValidation(event.password,
            event.passwordValidation, event.email, event.restaurantName,
            street: event.streetName, description: event.description);
        emit(RegisterSuccesful());
      } catch (e) {
        emit(RegisterFailure());
      }
    });
  }
}
