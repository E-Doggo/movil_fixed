import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/restaurant_info/bloc/restaurant_bloc.dart';
import 'package:proyecto_progra_movil/restaurant_info/datasource/restaurant_data_source.dart';
import 'package:proyecto_progra_movil/restaurant_info/repository/restaurant_repository.dart';
import 'package:proyecto_progra_movil/restaurant_info/ui/restaurant_builder.dart';

class RestaurantProvider extends StatelessWidget {
  const RestaurantProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestaurantBloc(
          resRepo: RestaurantRepo(resDataSource: RestaurantData())),
      child: const RestaurantBuilder(),
    );
  }
}
