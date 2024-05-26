import 'package:mapbox_gl/mapbox_gl.dart';

class RegisterEvent {
  RegisterEvent();
}

class RegisterNextStep extends RegisterEvent {
  final int type;
  RegisterNextStep({required this.type});
  @override
  List<Object> get props => [type];
}

class RegisterMapLoaded extends RegisterEvent {
  LatLng latLng;

  RegisterMapLoaded({required this.latLng});

  List<Object> get props => [latLng];
}

class RegisterRestaurant extends RegisterEvent {
  final String email;
  final String password;
  final String passwordValidation;
  final String restaurantName;
  final String streetName;
  final String description;
  final LatLng coords;

  RegisterRestaurant(
      {required this.email,
      required this.password,
      required this.passwordValidation,
      required this.restaurantName,
      required this.description,
      required this.streetName,
      required this.coords});

  @override
  List<Object> get props => [
        email,
        password,
        passwordValidation,
        restaurantName,
        description,
        streetName,
        coords
      ];
}
