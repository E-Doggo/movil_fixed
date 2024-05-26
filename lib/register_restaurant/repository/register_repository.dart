import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/register_restaurant/data_source/register_data_source.dart';

class RegisterResRepo {
  RegResDataSource dataSource;

  RegisterResRepo({required this.dataSource});

  Future<User?> passwordValidation(
    //should refactor this, breaking only one responsability rule

    String pass,
    String passValidation,
    String email,
    String username,
    String street,
    String description,
    LatLng coords,
    Timestamp openTime,
    Timestamp closingTime,
  ) async {
    if (pass == passValidation) {
      await dataSource.createUserAuth(email, pass);
      await dataSource.saveResDB(
          username, email, street, description, coords, openTime, closingTime);
    }
  }

  Timestamp convertTimeOfDayToTimestamp(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return Timestamp.fromDate(dateTime);
  }

  TimeOfDay convertTimestampToTimeOfDay(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
