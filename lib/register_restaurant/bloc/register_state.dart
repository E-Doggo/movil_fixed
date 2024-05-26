import 'package:mapbox_gl/mapbox_gl.dart';

class RegisterState {
  RegisterState();
}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  LatLng latLng;

  RegisterLoaded({required this.latLng});

  List<Object> get props => [latLng];
}

class RegisterValidating extends RegisterState {
  LatLng latLng;

  RegisterValidating({required this.latLng});

  List<Object> get props => [latLng];
}

class RegisterSuccesful extends RegisterState {}

class RegisterFailure extends RegisterState {
  LatLng latLng;

  RegisterFailure({required this.latLng});

  List<Object> get props => [latLng];
}
