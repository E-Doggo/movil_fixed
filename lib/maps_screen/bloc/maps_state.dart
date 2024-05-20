import 'package:mapbox_gl/mapbox_gl.dart';

class MapState {
  MapState();
}

class MapLoading extends MapState {}

class MapLoadedUser extends MapState {
  LatLng latLng;

  MapLoadedUser({required this.latLng});

  List<Object> get props => [latLng];
}

class MapSelectedRestaurant extends MapState {}

class MapFailedToLoad extends MapState {}
