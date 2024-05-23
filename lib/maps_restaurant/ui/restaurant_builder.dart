import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/app_bar.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_state.dart';

class RestaurantBuilder extends StatefulWidget {
  const RestaurantBuilder({super.key});

  @override
  State<RestaurantBuilder> createState() => _RestaurantBuilderState();
}

class _RestaurantBuilderState extends State<RestaurantBuilder> {
  @override
  Widget build(BuildContext context) {
    Widget restaurantDescription() {
      return Row(children: [
        const Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Text("Descripción"), //Necesita negrilla
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Descripcion del restaurante"),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Text("Direccion"), //Necesita negrilla
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Descripcion del restaurante"),
          )
        ]),
        Image.network("")
      ]);
    }

    Widget menu() {
      return Column(
        children: [
          const Text("Menú"),
          Row(
            children: [
              Image.network(""),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text("Titulo del platillo"), //Necesita negrilla
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Descripcion del platillo"),
                  )
                ],
              )
            ],
          )
        ],
      );
    }

    Widget loadingScreen() {
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
            Text("Espere la información esta cargando"),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Titulo restaurante"),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
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
          } else if (state is RestaurantLoaded) {
            return Column(
              children: [restaurantDescription(), menu()],
            );
          } else if (state is RestaurantLoadingFailed) {
            return const Center(
              child: Column(
                children: [
                  Text("Error al cargar la información del restaurante"),
                  Text("Intentelo de nuevo más tarde"),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
