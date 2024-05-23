import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/datasource/restaurant_data_source.dart';
import 'package:proyecto_progra_movil/maps_restaurant/repository/restaurant_repository.dart';
import 'package:proyecto_progra_movil/maps_restaurant/ui/restaurant_builder.dart';

class RestaurantProvider extends StatelessWidget {
  const RestaurantProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestaurantBloc(
        resRepo: RestaurantRepo(
          resDataSource: RestaurantData(),
        ),
      ),
      child: const RestaurantBuilder(),
    );
  }
}
