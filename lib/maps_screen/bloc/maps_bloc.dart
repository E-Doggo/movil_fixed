import 'package:bloc/bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_event.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_state.dart';
import 'package:proyecto_progra_movil/maps_screen/repository/maps_repository.dart';

class MapBloc extends Bloc<MapEvents, MapState> {
  MapRepo mapRepo;

  MapBloc({required this.mapRepo}) : super(MapLoading()) {
    _init();
    on<MapLoadedData>((event, emit) async {
      try {
        LatLng latLng = await mapRepo.getLatLngFromSharedPrefs();
        emit(MapLoadedUser(latLng: latLng));
      } catch (e) {
        emit(MapFailedToLoad());
      }
    });
  }

  Future<void> _init() async {
    await mapRepo.initializeLocationAndSave();
    add(MapLoadedData());
  }
}
