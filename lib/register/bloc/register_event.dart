import 'package:mapbox_gl/mapbox_gl.dart';

class RegisterEvent {
  RegisterEvent();
}

class RegisterSave extends RegisterEvent {
  final String email;
  final String password;
  final String passwordValidation;
  final String username;

  RegisterSave(
      {required this.email,
      required this.password,
      required this.passwordValidation,
      required this.username});

  @override
  List<Object> get props => [email, password, passwordValidation, username];
}
