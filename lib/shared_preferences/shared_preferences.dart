import 'package:shared_preferences/shared_preferences.dart';

class Shared_Preferences {
  Future<SharedPreferences> getPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }
}
