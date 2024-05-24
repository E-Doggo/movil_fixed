import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:proyecto_progra_movil/app_bar.dart';
import 'package:proyecto_progra_movil/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:proyecto_progra_movil/register/bloc/register_bloc.dart';
import 'package:proyecto_progra_movil/register/bloc/register_event.dart';
import 'package:proyecto_progra_movil/register/bloc/register_state.dart';
import 'package:proyecto_progra_movil/app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  final FireBaseAuthService auth = FireBaseAuthService();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  late MapboxMapController mapController;

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/silpancho-background-homepage.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildHeaderText() {
    return Container(
      color: const Color.fromARGB(255, 89, 206, 144), // Fondo verde
      padding: const EdgeInsets.symmetric(vertical: 1.0), // Ajustar espaciado
      alignment: Alignment.center,
      child: const Text(
        'RUTA GOURMET',
        style: TextStyle(
          fontSize: 36.0,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
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

  Card _buildCardForms(formKey) {
    return Card(
      child: Form(
        key: formKey,
        child: Column(children: <TextFormField>[
          mailValidation("Correo *"),
          textValidation("Nombre de Usuario *", _userController),
          passwordValidation("Contraseña *", 0),
          passwordValidation("Repita la contraseña *", 1),
        ]),
      ),
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

  Widget _registerUserCard(_formKey, bool validating) {
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
                  'Registro',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            _buildCardForms(_formKey),
            validating
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          String password = _passwordController.text.toString();
                          String email = _emailController.text.toString();
                          String passwordValidation =
                              _password2Controller.text.toString();
                          String username = _userController.text.toString();
                          context.read<RegisterBloc>().add(RegisterSave(
                              email: email,
                              password: password,
                              passwordValidation: passwordValidation,
                              username: username));
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
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: TextButton(
                onPressed: () {
                  context.read<RegisterBloc>().add(RegisterChange(type: 1));
                },
                child: const Text(
                  'Registrate como restaurante',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromRGBO(89, 206, 143, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerResCard(_formKey, state, validating) {
    dynamic _initialCameraPosition =
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
                _buildRestaurantCard(_formKey),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: MapboxMap(
                    accessToken:
                        "pk.eyJ1IjoiZG9nZ2VyLWUiLCJhIjoiY2x2ZDljMG9uMG42aDJrbGg4aG91M3l4OSJ9.-jl41NBFO9bMJa7H4lisnA",
                    initialCameraPosition: _initialCameraPosition,
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
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final FormState form = _formKey.currentState!;
                        if (form.validate()) {
                          String password = _passwordController.text.toString();
                          String email = _emailController.text.toString();
                          String passwordValidation =
                              _password2Controller.text.toString();
                          String username = _userController.text.toString();
                          String description =
                              _descripcionController.text.toString();
                          String street = _streetController.text.toString();
                          context.read<RegisterBloc>().add(
                                RegisterRestaurant(
                                    email: email,
                                    password: password,
                                    passwordValidation: passwordValidation,
                                    restaurantName: username,
                                    description: description,
                                    streetName: street,
                                    coords: state.latLng),
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
                context.read<RegisterBloc>().add(RegisterChange(type: 0));
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
    final _formKey = GlobalKey<FormState>();
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
                //_buildHeaderText(),
                BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                  if (state is RegisterWaiting) {
                    return _registerUserCard(_formKey, false);
                  } else if (state is RegisterValidating) {
                    return _registerUserCard(_formKey, true);
                  } else if (state is RegisterWaitingRestaurant) {
                    return _registerResCard(_formKey, state, false);
                  } else if (state is RegisterValidatingRestaurant) {
                    return _registerResCard(_formKey, state, true);
                  } else if (state is RegisterSuccesful) {
                    context.go("/preferences");
                    return const Text("");
                  } else {
                    _userController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    _password2Controller.clear();
                    _streetController.clear();
                    _descripcionController.clear();
                    return _buildCardForms(_formKey);
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
