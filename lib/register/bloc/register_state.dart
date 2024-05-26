import 'package:mapbox_gl/mapbox_gl.dart';

class RegisterState {
  RegisterState();
}

class RegisterWaiting extends RegisterState {}

class RegisterValidating extends RegisterState {}

class RegisterSuccesful extends RegisterState {
  // Aqui poner el firstTime = false
}

class RegisterFailure extends RegisterState {}
