import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/app_bar.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/register_restaurant/bloc/register_bloc.dart';
import 'package:proyecto_progra_movil/register_restaurant/bloc/register_event.dart';
import 'package:proyecto_progra_movil/register_restaurant/bloc/register_state.dart';

class RegisterResScreen extends StatefulWidget {
  const RegisterResScreen({super.key});

  @override
  State<RegisterResScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterResScreen> {
  final FireBaseAuthService auth = FireBaseAuthService();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  TimeOfDay openingTime = TimeOfDay.now();
  TimeOfDay closingTime = TimeOfDay.now();
  late MapboxMapController mapController;
  final formKey = GlobalKey<FormState>();

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/silpancho-background-homepage.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  TextFormField textValidation(
      String textHint, TextEditingController controllerType) {
    return TextFormField(
      controller: controllerType,
      decoration: InputDecoration(
        icon: const Icon(Icons.text_fields),
        labelText: textHint,
      ),
      validator: (String? value) {
        return (value!.isEmpty) ? "Complete el punto" : null;
      },
    );
  }

  TextFormField mailValidation(final String textHint) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        icon: const Icon(Icons.mail),
        labelText: textHint,
      ),
      validator: (String? value) {
        return (value != null && !value.contains('@'))
            ? 'Use the @ char.'
            : null;
      },
    );
  }

  TextFormField passwordValidation(final String textHint, final int type) {
    return TextFormField(
      controller: type == 0 ? _passwordController : _password2Controller,
      decoration: InputDecoration(
        icon: const Icon(Icons.lock),
        labelText: textHint,
      ),
      obscureText: true,
      validator: (String? value) {
        return (value!.isEmpty) ? "Ingrese una contraseña" : null;
      },
    );
  }

  Card _buildRestaurantCard(formKey) {
    return Card(
      child: Form(
        key: formKey,
        child: Column(children: <TextFormField>[
          mailValidation("Correo *"),
          textValidation("Nombre del restaurante *", _userController),
          passwordValidation("Contraseña *", 0),
          passwordValidation("Repita la contraseña *", 1),
          textValidation("Calle del restaurante *", _streetController),
          textValidation(
              "Descripcion del restaurante *", _descripcionController),
        ]),
      ),
    );
  }

  Widget _alertTimePicker(bool type) {
    //true apertura false cierre

    return ElevatedButton(
      onPressed: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          confirmText: "Seleccionar",
          cancelText: "Cancelar",
        );

        if (selectedTime != null) {
          setState(() {
            type ? openingTime = selectedTime : closingTime = selectedTime;
          });
        }
      },
      child: type
          ? const Text('Seleccionar hora de apertura')
          : const Text('Seleccionar hora de cierre'),
    );
  }

  Widget _formFieldTime(bool type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("Hora seleccionada"),
        type
            ? Text(
                "${openingTime.hour.toString()} : ${openingTime.minute.toString()} ")
            : Text(
                "${closingTime.hour.toString()} : ${closingTime.minute.toString()} "),
        _alertTimePicker(type)
      ],
    );
  }

  Widget _registerRestaurantCard(state, validating) {
    dynamic initialCameraPosition =
        CameraPosition(target: state.latLng, zoom: 15);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 89, 206, 144),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                _buildRestaurantCard(formKey),
                _formFieldTime(true),
                _formFieldTime(false),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: MapboxMap(
                    accessToken:
                        "pk.eyJ1IjoiZG9nZ2VyLWUiLCJhIjoiY2x2ZDljMG9uMG42aDJrbGg4aG91M3l4OSJ9.-jl41NBFO9bMJa7H4lisnA",
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: _onMapCreated,
                    onMapClick: (Point<double> point, LatLng coordinates) {
                      _addMarkerToSelectedPoint(coordinates);
                      state.latLng = coordinates;
                    },
                    styleString: "mapbox://styles/mapbox/light-v11",
                    minMaxZoomPreference: const MinMaxZoomPreference(14, 30),
                  ),
                )
              ],
            ),
            validating
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final FormState form = formKey.currentState!;
                        if (form.validate()) {
                          String password = _passwordController.text.toString();
                          String email = _emailController.text.toString();
                          String passwordValidation =
                              _password2Controller.text.toString();
                          String restaurantName =
                              _userController.text.toString();
                          String description =
                              _descripcionController.text.toString();
                          String streetName = _streetController.text.toString();
                          context.read<RegisterResBloc>().add(
                                RegisterRestaurant(
                                    email: email,
                                    password: password,
                                    passwordValidation: passwordValidation,
                                    restaurantName: restaurantName,
                                    description: description,
                                    streetName: streetName,
                                    coords: state.latLng,
                                    openingTime: openingTime,
                                    closingTime: closingTime),
                              );
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 89, 206, 144)),
                      ),
                      child: const Text("Registrarse",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Registrate como usuario',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Color.fromRGBO(89, 206, 143, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'RUTA GOURMET'),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: _buildBackgroundDecoration(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<RegisterResBloc, RegisterState>(
                    builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is RegisterLoaded) {
                    return _registerRestaurantCard(state, false);
                  } else if (state is RegisterValidating) {
                    return _registerRestaurantCard(state, true);
                  } else if (state is RegisterSuccesful) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go("/mainPage");
                    });
                    return SizedBox.shrink();
                  } else {
                    _userController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    _password2Controller.clear();
                    _streetController.clear();
                    _descripcionController.clear();
                    return _registerRestaurantCard(state, false);
                  }
                }),
              ],
            ),
          ),
        ));
  }

  _onMapCreated(MapboxMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  _addMarkerToSelectedPoint(LatLng coordinates) {
    mapController.clearSymbols();
    mapController.addSymbol(
      SymbolOptions(
        geometry: coordinates,
        iconSize: 0.5,
        iconImage: "assets/images/restaurant.png",
      ),
    );
  }
}
