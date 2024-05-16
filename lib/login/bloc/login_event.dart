import 'package:flutter/material.dart';

class LoginEvent {}

class LoginInput extends LoginEvent {
  final String email;
  final String password;

  LoginInput({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginFaceID extends LoginEvent {}

class LoginHuella extends LoginEvent {}

class checkLoginUserPrefs extends LoginEvent {
  final String email;

  checkLoginUserPrefs({required this.email});

  List<Object> get props => [email];
}

class LoginReload extends LoginEvent {}
