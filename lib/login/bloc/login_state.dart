import 'package:flutter/widgets.dart';

class LoginState {
  LoginState();
}

class LoginWaiting extends LoginState {}

class LoginSuccesfulNoPrefs extends LoginState {
  String email;

  LoginSuccesfulNoPrefs({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginSuccesfulPrefs extends LoginState {
  String email;

  LoginSuccesfulPrefs({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginSuccesfulRestaurant extends LoginState {}

class LoginFailed extends LoginState {}

class LoginForgotten extends LoginState {}
