import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_bloc.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(125, 43, 212, 1),
        title: const Text("Mapa de restaurantes cercanos"),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          if (state is MapLoading) {
            return Container(
              child: const Text("Espere el mapa esta cargando"),
            );
          } else if (state is MapLoadedUser) {
            dynamic _initialCameraPosition =
                CameraPosition(target: state.latLng, zoom: 15);
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: MapboxMap(
                  accessToken:
                      "pk.eyJ1IjoiZG9nZ2VyLWUiLCJhIjoiY2x2ZDljMG9uMG42aDJrbGg4aG91M3l4OSJ9.-jl41NBFO9bMJa7H4lisnA",
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: _onMapCreated,
                  onStyleLoadedCallback: () =>
                      _onStyleLoadedCallback(state.latLng, state.listLocations),
                  // myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                  styleString: "mapbox://styles/mapbox/light-v11",
                  minMaxZoomPreference: const MinMaxZoomPreference(14, 30),
                ));
          } else if (state is MapFailedToLoad) {
            return Container(
              child: const Text(
                  "No se pudo cargar el mapa por un error desconocido"),
            );
          }
          return Container();
        }),
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  _onStyleLoadedCallback(LatLng latLng, List listLocations) {
    mapController.addSymbol(
      SymbolOptions(
        geometry: latLng,
        iconSize: 0.5,
        iconImage: "assets/images/location.png",
      ),
    );
    _addRestaurantsMarkers(listLocations);
  }

  _addRestaurantsMarkers(List listLocations) {
    listLocations.forEach(
      (location) => mapController.addSymbol(
        SymbolOptions(
          geometry: location,
          iconSize: 1.25,
          iconImage: "assets/images/restaurant.png",
        ),
      ),
    );
  }
}