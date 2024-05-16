import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/login/bloc/login_event.dart';
import 'package:proyecto_progra_movil/login/bloc/login_state.dart';
import 'package:proyecto_progra_movil/login/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo;
  final FireBaseAuthService auth = FireBaseAuthService();
  LoginBloc({required this.loginRepo}) : super(LoginWaiting()) {
    on<LoginInput>((event, emit) async {
      try {
        final validation =
            await loginRepo.authenticateData(event.email, event.password);
        if (validation == true) {
          add(checkLoginUserPrefs(email: event.email));
        } else {
          emit(LoginFailed());
        }
      } catch (e) {
        emit(LoginFailed());
      }
    });
    on<LoginHuella>((event, emit) async {
      try {
        // token
        // faceID
        // Token
      } catch (e) {
        emit(LoginFailed());
      }
    }); //Implementar la logica de la libreria de la huella digital

    on<checkLoginUserPrefs>((event, emit) async {
      try {
        final List<String>? listPrefs =
            await loginRepo.getUserPreferences(event.email);
        if (listPrefs!.isNotEmpty) {
          emit(LoginSuccesfulNoPrefs(email: event.email));
        } else {
          emit(LoginSuccesfulPrefs(email: event.email));
        }
      } catch (e) {
        emit(LoginFailed());
      }
    });

    on<LoginReload>((event, emit) => emit(LoginWaiting()));
  }
}
