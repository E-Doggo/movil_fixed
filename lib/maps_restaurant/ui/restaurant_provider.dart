import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/datasource/restaurant_data_source.dart';
import 'package:proyecto_progra_movil/maps_restaurant/repository/restaurant_repository.dart';
import 'package:proyecto_progra_movil/maps_restaurant/ui/restaurant_builder.dart';

class RestaurantProvider extends StatelessWidget {
  final dynamic parameter;
  const RestaurantProvider({super.key, required this.parameter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestaurantBloc(
        parameter: parameter,
        resRepo: RestaurantRepo(
          resDataSource: RestaurantData(),
        ),
      ),
      child: const RestaurantBuilder(),
    );
  }
}
