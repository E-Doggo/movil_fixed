import 'package:mapbox_gl/mapbox_gl.dart';

class MapState {
  MapState();
}

class MapLoading extends MapState {}

class MapLoadedUser extends MapState {
  LatLng latLng;

  List<dynamic> listLocations;
  Map<Symbol, dynamic> symbolsMap = {};

  MapLoadedUser({required this.latLng, required this.listLocations});

  List<Object> get props => [latLng, listLocations, symbolsMap];
}

class MapSelectedRestaurant extends MapState {}

class MapFailedToLoad extends MapState {}
