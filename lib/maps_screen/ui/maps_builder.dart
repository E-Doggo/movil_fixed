import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_state.dart';
import 'package:proyecto_progra_movil/app_bar.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_bloc.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_state.dart';
import 'package:proyecto_progra_movil/maps_screen/model/symbol_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapboxMapController mapController;
  Map<Symbol, dynamic> _symbolsMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Mapa de restaurantes cercanos'),
      body: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
        if (state is MapLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 89, 206, 144),
                  ),
                ),
                Text("Espere el mapa esta cargando"),
              ],
            ),
          );
        } else if (state is MapLoadedUser) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: MapboxMap(
              accessToken:
                  "pk.eyJ1IjoiZG9nZ2VyLWUiLCJhIjoiY2x2ZDljMG9uMG42aDJrbGg4aG91M3l4OSJ9.-jl41NBFO9bMJa7H4lisnA",
              initialCameraPosition:
                  CameraPosition(target: state.latLng, zoom: 15),
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: () =>
                  _onStyleLoadedCallback(state.latLng, state.listLocations),
              // myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,

              styleString: "mapbox://styles/mapbox/light-v11",
              minMaxZoomPreference: const MinMaxZoomPreference(14, 30),
            ),
          );
        } else if (state is MapFailedToLoad) {
          return const Text(
              "No se pudo cargar el mapa por un error desconocido");
        }
        return Container();
      }),
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
      (location) async {
        final symbolOptions = SymbolOptions(
          geometry: location["coordinates"],
          iconSize: 1.25,
          iconImage: "assets/images/restaurant.png",
        );

        final symbol = await mapController.addSymbol(symbolOptions);
        _symbolsMap[symbol] = location["id"];
      },
    );
    mapController.onSymbolTapped.add(_onSymbolTapped);
  }

  void _onSymbolTapped(Symbol symbol) {
    final restaurantId = _symbolsMap[symbol];
    if (restaurantId != null) {
      context.goNamed("restaurant-info", extra: restaurantId);
    }
  }
}
