import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/maps_screen/data_source/maps_data_source.dart';
import 'package:proyecto_progra_movil/shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapRepo {
  MapDataSource mapDataSource;

  MapRepo({required this.mapDataSource});

  Future<LatLng> getLatLngFromSharedPrefs() async {
    SharedPreferences sharedPrefs = await Shared_Preferences().getPrefs();
    LatLng latLng = LatLng(sharedPrefs.getDouble('latitude')!,
        sharedPrefs.getDouble('longitude')!);
    return latLng;
  }

  Future<void> initializeLocationAndSave() async {
    SharedPreferences sharedPrefs = await Shared_Preferences().getPrefs();
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    LocationData locationData = await location.getLocation();

    sharedPrefs.setDouble('latitude', locationData.latitude!);
    sharedPrefs.setDouble('longitude', locationData.longitude!);
  }
}
