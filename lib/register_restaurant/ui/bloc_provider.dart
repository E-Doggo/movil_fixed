import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_screen/data_source/maps_data_source.dart';
import 'package:proyecto_progra_movil/maps_screen/repository/maps_repository.dart';
import 'package:proyecto_progra_movil/register_restaurant/bloc/register_bloc.dart';
import 'package:proyecto_progra_movil/register_restaurant/data_source/register_data_source.dart';
import 'package:proyecto_progra_movil/register_restaurant/repository/register_repository.dart';
import 'package:proyecto_progra_movil/register_restaurant/ui/bloc_builder.dart';

class RegisterResProvider extends StatelessWidget {
  const RegisterResProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterResBloc(
          registerRepo: RegisterResRepo(dataSource: RegResDataSource()),
          mapRepo: MapRepo(mapDataSource: MapDataSource())),
      child: const RegisterResScreen(),
    );
  }
}
