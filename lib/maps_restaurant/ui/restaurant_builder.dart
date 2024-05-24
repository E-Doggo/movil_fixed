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
    Widget restaurantDescription(Map<String, dynamic> resInfo) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                child: Text(
                  "Descripción",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ), //Necesita negrilla
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(resInfo["description"]),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                child: Text(
                  "Direccion",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ), //Necesita negrilla
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(resInfo["street"]),
              )
            ]),
        Container(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              resInfo["logo"],
              height: 120,
              fit: BoxFit.contain,
            ))
      ]);
    }

    Widget menu(Map<String, dynamic> resInfo) {
      return Column(
        children: [
          const Text(
            "Menú",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          ...resInfo["menu"].map((dish) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                children: [
                  Image.network(
                    dish["photoURL"],
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                          child: Text(
                            dish["dish"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dish["description"],
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                  child: restaurantDescription(state.restaruantInfo),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                  child: menu(state.restaruantInfo),
                )
              ],
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
