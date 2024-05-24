import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_progra_movil/app_bar.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_bloc.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_event.dart';
import 'package:proyecto_progra_movil/maps_restaurant/bloc/restaurant_state.dart';

class RestaurantBuilder extends StatefulWidget {
  const RestaurantBuilder({super.key});

  @override
  State<RestaurantBuilder> createState() => _RestaurantBuilderState();
}

class _RestaurantBuilderState extends State<RestaurantBuilder> {
  @override
  Widget build(BuildContext context) {
    //Get the restaurant name, description and logo from the DB
    Widget restaurantDescription(Map<String, dynamic> resInfo, bool favorite) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text(
                      "Descripción",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ), //Necesita negrilla
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      resInfo["description"],
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text(
                      "Direccion",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ), //Necesita negrilla
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(resInfo["street"],
                        softWrap: true, textAlign: TextAlign.justify),
                  )
                ]),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  resInfo["logo"],
                  height: MediaQuery.of(context).size.height * 0.175,
                  fit: BoxFit.contain,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.375,
                  child: favorite
                      ? ElevatedButton(
                          onPressed: () {
                            context.read<RestaurantBloc>().add(
                                RestaurantAddFavorite(
                                    resID: resInfo["restaurant_id"],
                                    resInfo: resInfo));
                          },
                          child:
                              const Text("Eliminar restaurante de favoritos"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            context.read<RestaurantBloc>().add(
                                RestaurantAddFavorite(
                                    resID: resInfo["restaurant_id"],
                                    resInfo: resInfo));
                          },
                          child: const Text(
                            "Añadir restaurante a favoritos",
                          ),
                        ),
                ),
              ],
            ),
          )
        ]),
      );
    }

    //Get the menu from the DB
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

    PreferredSize restaurantAppBar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
            builder: (context, state) {
          if (state is RestaurantLoading) {
            return const CustomAppBar(
              title: "Cargando",
            );
          } else if (state is RestaurantLoaded) {
            return CustomAppBar(
              title: state.restaruantInfo["name"],
            );
          }
          if (state is RestaurantLoading) {
            return const CustomAppBar(
              title: "Cargado fallido",
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      );
    }

    return Scaffold(
      appBar: restaurantAppBar(),
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
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                    child: restaurantDescription(
                        state.restaruantInfo, state.restaurantFavorite),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
                    child: menu(state.restaruantInfo),
                  )
                ],
              ),
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
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
