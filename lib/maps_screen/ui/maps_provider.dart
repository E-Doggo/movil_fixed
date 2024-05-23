import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_screen/bloc/maps_bloc.dart';
import 'package:proyecto_progra_movil/maps_screen/data_source/maps_data_source.dart';
import 'package:proyecto_progra_movil/maps_screen/repository/maps_repository.dart';
import 'package:proyecto_progra_movil/maps_screen/ui/maps_builder.dart';

class MapProvider extends StatelessWidget {
  const MapProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapBloc(mapRepo: MapRepo(mapDataSource: MapDataSource())),
      child: const MapScreen(),
    );
  }
}
